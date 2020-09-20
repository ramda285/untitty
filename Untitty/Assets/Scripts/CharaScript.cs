using System.Collections;
using System.Collections.Generic;
using Photon.Pun;
using UnityEngine;

public class CharaScript : MonoBehaviourPunCallbacks, IPunObservable
{
    //コンポーネント
	public Rigidbody2D rb2d;
	public AudioSource auso;
    //ゲームオブジェクト(リソース)
	public GameObject Bullet;
	public GameObject Kuso;
	public GameObject Chakuti;
    //ゲームオブジェクト(フィールド)
	public GameObject manager;
	//マネージャー
	GameObject ShotM;
	GameObject ChakuchiM;
	GameObject HisanM;
	public GameObject touch;
    //ＳＥ
    public AudioClip pyon;
	public AudioClip tyakuti;
	public AudioClip bomb;
	public AudioClip bobobo;
    //送信データ
	public bool jump, dead;
	public float mx;
    private int projectileId;
    //能力
	public Vector2 jumpvector;
	public float speed;
	public Vector2 three = new Vector2(0f, 0f);
    //消したいけど消せない
    public int toward = 1;
    //死亡時タイマー
	float t;
	//シェーダーかけるフレーム
	float cametime = 0;
	//通信時間
	float elapsedTime;
	//線形補完の前、後
	float start, end;
	//補間速度
	float sendvelo;
	int timelag = 0;

	void Awake()
	{
		this.rb2d = base.GetComponent<Rigidbody2D>();
		this.auso = base.GetComponent<AudioSource>();
		Chakuti = (GameObject)Resources.Load("Chakuchi");
		//manager_child:0弾、1着地、2飛散
		this.manager = GameObject.FindWithTag("Manager");
		ShotM = manager.transform.GetChild(0).gameObject;
		ChakuchiM = manager.transform.GetChild(1).gameObject;
		HisanM = manager.transform.GetChild(2).gameObject;
		this.touch = GameObject.Find("TouchManager");
		//ネット対戦かつ王冠もちで生成
		if (TitleScript.minnamode && base.photonView.IsMine && PhotonScript.king == 1)
		{
			PhotonNetwork.Instantiate("Ohcan", base.transform.position + Vector3.up, Quaternion.identity, 0, null).transform.parent = base.transform;
			//PhotonNetwork.Instantiate("Fry", base.transform.position + Vector3.up, Quaternion.identity, 0, null).transform.parent = base.transform;
		}
		
	}

	public void Move(){
		print(transform.position);
		//死んでいる場合
		if (this.dead){
			//0.5秒だけネガ
			if(cametime < 0.05f){
				cametime += Time.deltaTime;
			}else{
				Camera.main.GetComponent<PP>().enabled = false;
			}
			//フレーム
			Time.fixedDeltaTime = 0.02f * Time.timeScale;
			//バイブ
			//Handheld.Vibrate();
			//画面揺れ
			ComonScript.Shaking();
			//時間
			this.t+=Time.deltaTime*60;
			//残り5フレームでスローにする
			if (t > 95){
				ComonScript.shakestop = true;
				Time.timeScale = 0.07f;
				//カメラを移動、ズームイン
				Camera.main.transform.position -= new Vector3((Camera.main.transform.position.x - this.transform.position.x)/10,(Camera.main.transform.position.y - this.transform.position.y)/10,0);
				Camera.main.orthographicSize -= 0.08f;
			}else{
				//スロー中はくそを出さない（出したらもそっと出る）
				HisanM.GetComponent<ShotManageScript>().Fire(15, -2, transform.position - Vector3.forward * 3 , new Vector2(Random.Range(-8f, 8f), Random.Range(4f, 16f)));
			}
			//爆散
			if (this.t >= 100){
				Time.timeScale = 1f;
				Time.fixedDeltaTime = 0.02f * Time.timeScale;
				//80個のう〇こ
				while (this.t < 180){
					HisanM.GetComponent<ShotManageScript>().Fire(15, -2, transform.position, new Vector2(Random.Range(-8f, 8f), Random.Range(4f, 16f)));
					this.t++;
				}
				if (this.manager.GetComponent<PvpScript>() != null){
					this.manager.GetComponent<PvpScript>().someonesdeath = true;
				}
				DestroyImmediate(base.gameObject, true);
			}
			return;
		}

		//オンラインでは自機のみ操作
		if (!TitleScript.minnamode || base.photonView.IsMine){
			//傾きでジャンプ方向変化
			if (this.mx > 0f){
				this.toward = 1;
			}else if (this.mx < 0f){
				this.toward = -1;
			}

			//スマホ傾け移動
			if ((double)Mathf.Abs((float)System.Math.Round((double)Input.acceleration.x, 3) * ComonScript.kando) <= 0.1){
				this.mx = 0f;
			}else if ((double)Mathf.Abs((float)System.Math.Round((double)Input.acceleration.x, 3) * ComonScript.kando) < 0.5){
				this.mx = (float)((int)(System.Math.Round((double)Input.acceleration.x, 3) * (double)ComonScript.kando * 10.0) * 2);
			}else if (System.Math.Round((double)Input.acceleration.x, 3) * (double)ComonScript.kando <= -0.5){
				this.mx = -10f;
			}else if (System.Math.Round((double)Input.acceleration.x, 3) * (double)ComonScript.kando >= 0.5){
				this.mx = 10f;
			}
			//デバッグ用キー移動
			if (Input.GetKey(KeyCode.RightArrow)){
				this.mx = 5f * ComonScript.kando;
			}
			if (Input.GetKey(KeyCode.LeftArrow)){
				this.mx = -5f * ComonScript.kando;
			}

			//ショット
			if (this.touch.GetComponent<TouchReactScript>().shot || Input.GetButtonUp("Fire")){
				//オンラインではRPC
				if (TitleScript.minnamode){
                    photonView.RPC(nameof(Shot), RpcTarget.All, ++projectileId, photonView.OwnerActorNr);
				}else{
					Shot(projectileId++, 1);
				}
                this.touch.GetComponent<TouchReactScript>().shot = false;
			}

			//ジャンプ
            if (this.touch.GetComponent<TouchReactScript>().jump || Input.GetButtonUp("Jump")){
				//オンラインではRPC
				if (TitleScript.minnamode){
                    photonView.RPC(nameof(Jump), RpcTarget.All);
				}else{
					this.Jump();
				}
				this.touch.GetComponent<TouchReactScript>().jump = false;
			}
			//移動
			sendvelo = mx * speed * 60f;
			if (jump){
				transform.position += Vector3.right * sendvelo * Time.deltaTime;
			}
		}else{
			//線形補間
			elapsedTime += Time.deltaTime;
			if(Mathf.Abs(start - end) > 20f){
				transform.position = new Vector3(end, transform.position.y, -1);;
			}else{
				transform.position = new Vector3(Mathf.Lerp(start, end, elapsedTime / 0.2f), transform.position.y, -1);
			}
		}
	}

    [PunRPC]
	public void Jump(){
		if (this.jump){
			this.auso.PlayOneShot(this.pyon);
			this.rb2d.AddForce(this.jumpvector);
			this.jump = false;
		}
	}

	[PunRPC]
	public void Shot(int id, int num){
		this.auso.PlayOneShot(this.bomb);
		this.ShotM.GetComponent<ShotManageScript>().Fire(id, num, base.transform.position, this.three);
	}

    [PunRPC]
	public void Death(){
		if (dead == false){
			this.auso.PlayOneShot(this.bobobo);
			//カメラネガ
			Camera.main.GetComponent<PP>().enabled = true;
		}
		this.rb2d.isKinematic = false;
		this.dead = true;
	}

	void OnCollisionEnter2D(Collision2D obj){
		this.auso.PlayOneShot(this.tyakuti);
		if (obj.gameObject.name == "Ground"){
			this.jump = true;
		}
		if(Mathf.Abs(GetComponent<Rigidbody2D>().velocity.y) < 1f){
			GetComponent<Rigidbody2D>().velocity = new Vector2(GetComponent<Rigidbody2D>().velocity.x,0);
		}
		//バウンドの大きさによっては打ち切る
		//着地エフェクトを出す
		ChakuchiM.GetComponent<ShotManageScript>().Fire(15, -2, transform.position + new Vector3(0,-1f,-1f) , Vector2.zero);
	}

	private void OnTriggerEnter2D(Collider2D collision){
		ShotScript component = collision.GetComponent<ShotScript>();
		if (collision.gameObject.name == "WarpL"){
			base.transform.position += Vector3.right * 24.3f;
		}else if (collision.gameObject.name == "WarpR"){
			base.transform.position += Vector3.left * 24.3f;
		}else if (collision.gameObject.name == "Death"){
			if (this.manager.GetComponent<PvpScript>() != null)
				this.manager.GetComponent<PvpScript>().someonesdeath = true;
			DestroyImmediate(base.gameObject, true);
		}
		if (base.photonView.IsMine && component != null && component.OwnerId != PhotonNetwork.LocalPlayer.ActorNumber){
			photonView.RPC(nameof(Death), RpcTarget.All);
		}
		if (component.OwnerId == -1){
			this.Death();
		}
	}

	void IPunObservable.OnPhotonSerializeView(PhotonStream stream, PhotonMessageInfo info){
		if (stream.IsWriting){
			stream.SendNext(transform.position.x);
			stream.SendNext(sendvelo);
		}else{
			start = transform.position.x;
			float networkPosition = (float)stream.ReceiveNext();
            float networkVelocityPerSecond = (float)stream.ReceiveNext();
            var lag = Mathf.Max(0f, unchecked((float)(PhotonNetwork.ServerTimestamp - timelag)) / 1000f);
			timelag = PhotonNetwork.ServerTimestamp;
            end = networkPosition + networkVelocityPerSecond * lag;
            elapsedTime = 0f;
		}
	}
}