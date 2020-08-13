<<<<<<< HEAD
﻿using System.Collections;
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
    //ゲームオブジェクト(フィールド)
	private GameObject manager;
	private GameObject kusodas;
	public GameObject touch;
    //ＳＥ
    public AudioClip pyon;
	public AudioClip tyakuti;
	public AudioClip bomb;
	public AudioClip bobobo;
    //送信データ
	public bool jump, dead;
	public float mx,ex;
    private int projectileId;
    //能力
	public Vector2 jumpvector;
	public float speed;
	public Vector2 three = new Vector2(0f, 0f);
    //消したいけど消せない
    public int toward = 1;
    //死亡時タイマー
	float t;
	

	void Awake()
	{
		this.rb2d = base.GetComponent<Rigidbody2D>();
		this.auso = base.GetComponent<AudioSource>();
		this.manager = GameObject.FindWithTag("Manager");
		this.touch = GameObject.Find("TouchManager");
		this.kusodas = GameObject.Find("Kusodas");
		//ネット対戦かつ王冠もちで生成
		if (TitleScript.minnamode && base.photonView.IsMine && PhotonScript.king == 1)
		{
			PhotonNetwork.Instantiate("Ohcan", base.transform.position + Vector3.up, Quaternion.identity, 0, null).transform.parent = base.transform;
			//PhotonNetwork.Instantiate("Fry", base.transform.position + Vector3.up, Quaternion.identity, 0, null).transform.parent = base.transform;
		}
		
	}

	public void Move(){
		if (this.dead){
			//Handheld.Vibrate();
			ComonScript.Shaking();
			kusodas.GetComponent<ShotManageScript>().Fire(15, -2, transform.position , new Vector2(Random.Range(-8f, 8f), Random.Range(4f, 16f)), Kuso.GetComponent<ShotScript>());
			this.t+=Time.deltaTime*60;
			if (this.t >= 100){
				//this.t = 100;
				while (this.t < 180){
					kusodas.GetComponent<ShotManageScript>().Fire(15, -2, transform.position, new Vector2(Random.Range(-8f, 8f), Random.Range(4f, 16f)), Kuso.GetComponent<ShotScript>());
					this.t++;
				}
				if (this.manager.GetComponent<PvpScript>() != null){
					this.manager.GetComponent<PvpScript>().someonesdeath = true;
				}
				DestroyImmediate(base.gameObject, true);
			}
			return;
		}
		if (!TitleScript.minnamode || base.photonView.IsMine){
			if (this.mx > 0f){
				this.toward = 1;
			}else if (this.mx < 0f){
				this.toward = -1;
			}
			if ((double)Mathf.Abs((float)System.Math.Round((double)Input.acceleration.x, 3) * ComonScript.kando) <= 0.1){
				this.mx = 0f;
			}else if ((double)Mathf.Abs((float)System.Math.Round((double)Input.acceleration.x, 3) * ComonScript.kando) < 0.5){
				this.mx = (float)((int)(System.Math.Round((double)Input.acceleration.x, 3) * (double)ComonScript.kando * 10.0) * 2);
			}else if (System.Math.Round((double)Input.acceleration.x, 3) * (double)ComonScript.kando <= -0.5){
				this.mx = -10f;
			}else if (System.Math.Round((double)Input.acceleration.x, 3) * (double)ComonScript.kando >= 0.5){
				this.mx = 10f;
			}
			if (Input.GetKey(KeyCode.RightArrow)){
				this.mx = 5f * ComonScript.kando;
			}
			if (Input.GetKey(KeyCode.LeftArrow)){
				this.mx = -5f * ComonScript.kando;
			}
			if (this.touch.GetComponent<TouchReactScript>().shot || Input.GetButtonUp("Fire")){
				if (TitleScript.minnamode){
                    photonView.RPC(nameof(Shot), RpcTarget.All, ++projectileId, photonView.OwnerActorNr);
				}else{
					Shot(projectileId++, 1);
				}
                this.touch.GetComponent<TouchReactScript>().shot = false;
			}
            if (this.touch.GetComponent<TouchReactScript>().jump || Input.GetButtonUp("Jump")){
				if (TitleScript.minnamode){
                    photonView.RPC(nameof(Jump), RpcTarget.All);
				}else{
					this.Jump();
				}
				this.touch.GetComponent<TouchReactScript>().jump = false;
			}

			if (jump){
				transform.position += new Vector3(mx * speed * Time.deltaTime*60, 0f, 0f);
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
		this.manager.GetComponent<ShotManageScript>().Fire(id, num, base.transform.position, this.three, this.Bullet.GetComponent<ShotScript>());
	}

    [PunRPC]
	public void Death(){
		if (dead == false){
			this.auso.PlayOneShot(this.bobobo);
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
		Instantiate((GameObject)Resources.Load("Chakuchi"),transform.position + new Vector3(0,-1f,-1f),Quaternion.identity);
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
		/*もうどうしようもない
		if (stream.IsWriting){
			ex = this.transform.position.x;
			stream.SendNext(ex);
			return;
		}else{
			this.ex = (float)stream.ReceiveNext();
			base.transform.position = new Vector3(ex,transform.position.y,0);
			print(ex);
		}*/
	}
}
=======
﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharaScript : MonoBehaviour {

	public Rigidbody2D rb2d;
	public GameObject Bullet;
	public GameObject Kuso;
	public GameObject hisan;
    public GameObject MoveR;
    public GameObject MoveL;
    public bool jump = false , dead = false;
    public int mx;
	public int toward = 1 , t;
    public Vector2 jumpvector;
    public AudioSource pyon;
    public AudioSource tyakuti;
    public AudioSource bomb;
    public AudioSource bobobo;
    public AudioSource onara;

    public void Move () {
        //死亡時
        if (dead == true){
			hisan = Instantiate (Kuso,transform.position,Quaternion.identity) as GameObject;
			hisan.GetComponent<Rigidbody2D>().AddForce(new Vector2(Random.Range(-400.0f,400.0f),Random.Range(200.0f,800.0f)));
			t++;
			if (t == 100){
				for (t=100;t<180;t++){
					hisan = Instantiate(Kuso,transform.position,Quaternion.identity) as GameObject;
					hisan.GetComponent<Rigidbody2D>().AddForce(new Vector2(Random.Range(-400.0f,400.0f),Random.Range(200.0f,800.0f)));
				}
                DestroyImmediate(gameObject,true);
			}
            return;
		}
        //地上時
        //ジャンプ方向調節
        if (mx > 0)
        {
            toward = 1;
        }
        else if (mx < 0)
        {
            toward = -1;
        }
        //傾きから移動
        if(Mathf.Abs((float)System.Math.Round(Input.acceleration.x,3)) <= 0.1){
            //0近似
            mx = 0;
        }else if(Mathf.Abs((float)System.Math.Round(Input.acceleration.x,3)) >= 0.5){
            //45°で最大
            mx = (int)(System.Math.Round(Input.acceleration.x,3)*10)*2;
        }else if(System.Math.Round(Input.acceleration.x,3) <= -0.5){
            mx = -10;
        }else if(System.Math.Round(Input.acceleration.x,3) >= 0.5){
            mx = 10;
        }
        if (jump == true)
            transform.position += new Vector3(mx*0.007f,0,0);
        if (this.tag == "Player1" && Input.GetButtonUp("muimi1") || this.tag == "Player2" && Input.GetButtonUp("muimi2") || this.tag == "Player3" && Input.GetButtonUp("muimi3") || this.tag == "Player4" && Input.GetButtonUp("muimi4"))
        {
            onara.PlayOneShot(onara.clip);
        }
	}
    //ジャンプ関数
    public void Jump(){
        if (jump == true){
            pyon.PlayOneShot(pyon.clip);
            rb2d.AddForce(jumpvector);
			jump = false;
            //移動は地上のみ
		}
    }
    //ショット関数
	public void Shot () {
		GameObject shot = Instantiate(Bullet,transform.position,Quaternion.identity) as GameObject;
        bomb.PlayOneShot(bomb.clip);
        if (this.tag == "Player1")
        {
            shot.tag = "ShotA";
        }
        else if (this.tag == "Player2")
        {
            shot.tag = "ShotB";
        }
        else if (this.tag == "Player3")
        {
            shot.tag = "ShotC";
        }
        else if (this.tag == "Player4")
        {
            shot.tag = "ShotD";
        }
    }
    //死亡フラグON
	void Death () {
        if(dead == false)
            bobobo.PlayOneShot(bobobo.clip);
        rb2d.isKinematic = false;
		dead = true;
	}

	void OnCollisionEnter2D (Collision2D obj) {
        tyakuti.PlayOneShot(tyakuti.clip);
        if (obj.gameObject.name == "Ground") {
            jump = true;
            for (int i = 0; i < 3; i++)
            {
                hisan = Instantiate(Kuso, transform.position, Quaternion.identity) as GameObject;
                hisan.transform.localScale = new Vector3(0.2f,0.2f,1);
                hisan.GetComponent<Rigidbody2D>().AddForce(new Vector2(Random.Range(-100.0f, 100.0f), Random.Range(150.0f, 250.0f)));
            }
        }
    }

    void OnTriggerEnter2D (Collider2D obj)
    {
        if (obj.gameObject.name == "WarpL")
        {
            transform.position += Vector3.right * 27.5f;
            //rb2d.velocity = new Vector3(rb2d.velocity.x, rb2d.velocity.y, 0);
        }
        if (obj.gameObject.name == "WarpR")
        {
            transform.position += Vector3.left * 27.5f;
            //rb2d.velocity = new Vector3(rb2d.velocity.x, rb2d.velocity.y, 0);
        }
    }
}
>>>>>>> origin/master
