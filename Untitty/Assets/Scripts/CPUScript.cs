using System.Collections;
using System.Collections.Generic;
using UnityEngine;

class CPUScript : MonoBehaviour {

	Rigidbody2D rb2d;
    AudioSource auso;
	public GameObject Bullet;
    public GameObject Kuso;
    public GameObject Chakuti;
	GameObject enemy;
    public GameObject manager;
    GameObject ShotM;
	GameObject ChakuchiM;
	GameObject HisanM;
    public AudioClip pyon;
    public AudioClip tyakuti;
    public AudioClip bomb;
    public AudioClip bobobo;
    //移動に使用
    public int maai = 0; //間合い
    public int mtime = 0; //間合い変更
	public int hani = 10;	//敵察知範囲
    float mx,my,ex,ey;  //位置の特定
    public bool jump = false , dead = false;
	int toward = 1;	//向き
	int Sroop = 0;	//発射速度
	int jtime = 0;	//ジャンプ猶予
    private int projectileId = 0;
	float t;
	float cametime = 0;
    //難易度は0雑魚,1普通,2強い

	void Awake () {
		rb2d = GetComponent<Rigidbody2D>();
        auso = GetComponent<AudioSource>();
        enemy = GameObject.FindWithTag("Player1");
        manager = GameObject.FindWithTag("Manager");
        ShotM = manager.transform.GetChild(0).gameObject;
		ChakuchiM = manager.transform.GetChild(1).gameObject;
		HisanM = manager.transform.GetChild(2).gameObject;
	}

    public void Update(){
        if (dead){
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
		}else{
            if (ComonScript.nanid == 3) return;
            //m：自機（こいつ）、e：敵機（プレイヤー）
            mx = transform.position.x;
            my = transform.position.y;
            ex = enemy.transform.position.x;
            ey = enemy.transform.position.y;

            //向き
            if (mx < ex){
                toward = 1;
            }else{
                toward = -1;
            }

            //ロジック変更
            mtime--;
            if (mtime <= 0){
                mtime = Random.Range(50, 100);
                maai = Random.Range(2, 10);  //間合いの距離
                hani = Random.Range(4, 8);	//敵察知の距離
                if(ComonScript.nanid == 0){
                    maai = Random.Range(5, 10);
                    hani = Random.Range(10, 15);
                }
            }
            
            //間合いに合わせた移動
            if (jump == true){
                //壁をはさまない
                if (ComonScript.nanid == 0 || Mathf.Abs(mx - ex) < 15){
                    //間合いより遠い
                    if (Mathf.Abs(mx - ex) > maai + 1){
                        Move(true, 0.07f);  //近づく
                    }else if (Mathf.Abs(mx - ex) < maai - 1){
                        Move(false, 0.07f);    //遠のく
                    }
                //壁を挟む
                }else{
                    toward *= -1;
                    if (30 - Mathf.Abs(mx - ex) < maai - 1){
                        Move(false, 0.07f);  //近づく
                    }else if (30 - Mathf.Abs(mx - ex) > maai + 1){
                        Move(true, 0.07f);    //遠のく
                    }
                }
                
            }

            //敵察知
            if ((Mathf.Abs(mx - ex) < hani) || (30 - Mathf.Abs(mx - ex) < hani)){
                //ショット機能
                if (my > ey + 0.1f){
                    if (Sroop > 8){
                        Shot(++projectileId);
                        //難易度分岐
                        if (ComonScript.nanid == 0)
                            Sroop -= 15;
                        if (ComonScript.nanid == 1)
                            Sroop -= 10;
                        if (ComonScript.nanid == 2)
                            Sroop -= 5;
                    }
                    Sroop++;
                //ジャンプ
                }else if ((my <= ey + 2) && (my >= ey - 3) && (jump == true) && (jtime <= 0)){
                    Jump();
                //逃げる
                }else if (my < ey - 1)
                //else if ((my < ey - 0.8) && (TitleScript.selectmode == 5))
                {
                    //難易度分岐
                    if(ComonScript.nanid == 1)
                        Move(false, 0.02f);
                    if(ComonScript.nanid == 2)
                        Move(false, 0.05f);
                    print("特別逃げシステム");
                }
            }
        }
        //ジャンプ猶予
        if (jtime >= 0)
            jtime--;
    }

	void Jump () {
        //難易度分岐
        auso.PlayOneShot(pyon);
        if(ComonScript.nanid == 0)
            rb2d.AddForce(new Vector2(toward * 2.5f, 5) * 100);
        if(ComonScript.nanid == 1)
            rb2d.AddForce(new Vector2(toward * 3.5f, 7) * 100);
        if(ComonScript.nanid == 2)
            rb2d.AddForce(new Vector2(toward * 4.5f, 7) * 100);
		jump = false;
	}

    void Shot (int id) {
        auso.PlayOneShot(bomb);
        ShotM.GetComponent<ShotManageScript>().Fire(id, -1, transform.position, new Vector2(0,0));
    }

	void Death () {
        if(dead == false){
            auso.PlayOneShot(bobobo);
            //カメラネガ
			Camera.main.GetComponent<PP>().enabled = true;
        }
        rb2d.isKinematic = false;
		dead = true;
	}

	void Move (bool x,float y) {
		if (x == true){			//近づく
			transform.position += Vector3.right * y * toward;
		}else{					//遠のく
			transform.position += Vector3.left * y * toward;
		}
	}

    //地面との接触判定
	void OnCollisionEnter2D (Collision2D obj) {
        this.auso.PlayOneShot(this.tyakuti);
		if ((dead == false)&&(obj.gameObject.tag == "ground")){
            jump = true;
            if(ComonScript.nanid == 0)
                jtime = Random.Range (30,50);
            if(ComonScript.nanid == 1)
                jtime = Random.Range (15,35);
            if(ComonScript.nanid == 2)
                jtime = 0;
        }
		if(Mathf.Abs(GetComponent<Rigidbody2D>().velocity.y) < 1f){
			GetComponent<Rigidbody2D>().velocity = new Vector2(GetComponent<Rigidbody2D>().velocity.x,0);
		}
		//バウンドの大きさによっては打ち切る
		//着地エフェクトを出す
		ChakuchiM.GetComponent<ShotManageScript>().Fire(15, -2, transform.position + new Vector3(0,-1f,-1f) , Vector2.zero);
	}

    void OnTriggerEnter2D(Collider2D obj){
        var projectile = obj.GetComponent<ShotScript>();
        if (obj.gameObject.name == "WarpL"){
            transform.position += Vector3.right * 24.5f;
        }
        if (obj.gameObject.name == "WarpR"){
            transform.position += Vector3.left * 24.5f;
        }else if (obj.gameObject.name == "Death"){
			if (this.manager.GetComponent<PvpScript>() != null)
				this.manager.GetComponent<PvpScript>().someonesdeath = true;
			DestroyImmediate(base.gameObject, true);
		}
        if (projectile.OwnerId != -1) {
            Death();
        }
    }
}
