//タイトル画面でうろつくうんこのAI
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

class CPUTitleScript : MonoBehaviour {

	Rigidbody2D rb2d;
    AudioSource auso;
	public GameObject Bullet;
    public GameObject Kuso;
    public GameObject manager;
    public GameObject kusodas;
    public AudioClip pyon;
    public AudioClip tyakuti;
    public AudioClip bomb;
    public AudioClip bobobo;
    //移動する方向
    int moving = 0;
    //ロジック変更
    int mtime = 0;
    //糞番号
    int number = 0;
    bool jump = true , dead = false;
	int toward = 1;	//向き
	int Sroop = 0;	//発射速度
    int jtime = 0;	//ジャンプ猶予
    private int projectileId = 0;
	float t;

	void Awake () {
		rb2d = GetComponent<Rigidbody2D>();
        auso = GetComponent<AudioSource>();
        manager = GameObject.Find("Tamadas");
        kusodas = GameObject.Find("Kusodas");
        number = TitleScript.kusosum;
	}

    public void Update(){
        if (dead){
			//時間
			this.t+=Time.deltaTime*60;
			kusodas.GetComponent<ShotManageScript>().Fire(15, -2, transform.position - Vector3.forward * 3 , new Vector2(Random.Range(-8f, 8f), Random.Range(4f, 16f)), Kuso.GetComponent<ShotScript>());
			//爆散
			if (this.t >= 100){
				//80個のう〇こ
				while (this.t < 180){
					kusodas.GetComponent<ShotManageScript>().Fire(15, -2, transform.position, new Vector2(Random.Range(-8f, 8f), Random.Range(4f, 16f)), Kuso.GetComponent<ShotScript>());
					this.t++;
				}
				DestroyImmediate(base.gameObject, true);
			}
			return;
		}else{
            //ロジック変更
            mtime--;
            if (mtime <= 0){
                mtime = Random.Range(30, 300);
                moving++;
            }
            
            //間合いに合わせた移動
            if (jump){
                if (moving % 2 == 1){
                    Move(true, 0.05f);
                    toward = 1;
                }else{
                    Move(false, 0.05f);
                    toward = -1;
                }
                //ジャンプ
                jtime--;
                if (jtime < 0){
                    Jump();
                }
            }
            //ショット機能
            if (jump == false){
                if (Sroop > 8){
                    Shot(++projectileId);
                    Sroop -= 20;
                }
                Sroop++;
            }
        }
    }

	void Jump () {
        //難易度分岐
        auso.PlayOneShot(pyon);
        rb2d.AddForce(new Vector2(toward * Random.Range (2,4), Random.Range (3,6)) * 100);
		jump = false;
	}

    void Shot (int id) {
        auso.PlayOneShot(bomb);
        manager.GetComponent<ShotManageScript>().Fire(id, number, transform.position, new Vector2(0,0), Bullet.GetComponent<ShotScript>());
    }

	void Death () {
        if(dead == false){
            auso.PlayOneShot(bobobo);
        }
        rb2d.isKinematic = false;
		dead = true;
	}

	void Move (bool x,float y) {
		if (x == true){			//近づく
			transform.position += Vector3.right * y;
		}else{					//遠のく
			transform.position += Vector3.left * y;
		}
	}

    //地面との接触判定
	void OnCollisionEnter2D (Collision2D obj) {
        this.auso.PlayOneShot(this.tyakuti);
		if ((dead == false)&&(obj.gameObject.tag == "ground")){
            jump = true;
            jtime = Random.Range (150,400);
        }
		if(Mathf.Abs(GetComponent<Rigidbody2D>().velocity.y) < 1f){
			GetComponent<Rigidbody2D>().velocity = new Vector2(GetComponent<Rigidbody2D>().velocity.x,0);
		}
		//バウンドの大きさによっては打ち切る
		//着地エフェクトを出す
		Instantiate((GameObject)Resources.Load("Chakuchi"),transform.position + new Vector3(0,-1f,-1f),Quaternion.identity);
	}

    void OnTriggerEnter2D(Collider2D obj){
        var projectile = obj.GetComponent<ShotScript>();
        if (obj.gameObject.name == "WarpL"){
            transform.position += Vector3.right * 24.5f;
        }
        if (obj.gameObject.name == "WarpR"){
            transform.position += Vector3.left * 24.5f;
        }else if (obj.gameObject.name == "Death"){
			DestroyImmediate(base.gameObject, true);
		}
        if (projectile.OwnerId != number) {
            Death();
        }
    }
}
