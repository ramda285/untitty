﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

class CPUScript : MonoBehaviour {

	Rigidbody2D rb2d;
    AudioSource auso;
	public GameObject Bullet;
    public GameObject Kuso;
	GameObject enemy;
    GameObject manager;
    GameObject kusodas;
    public AudioClip pyon;
    public AudioClip tyakuti;
    public AudioClip bomb;
    public AudioClip bobobo;
    float mx,my,ex,ey;

    bool jump = false , dead = false;
	int toward = 1;	//向き
	int Sroop = 0;	//発射速度
	int jtime = 0;	//ジャンプ猶予
	int maai = 0; //間合い
    int mtime = 0; //間合い変更
	int hani = 10;	//敵察知範囲
    private int projectileId = 0;
	int t;

	void Start () {
		rb2d = GetComponent<Rigidbody2D>();
        auso = GetComponent<AudioSource>();
        //enemy = GameObject.Find("CharaA");
        enemy = GameObject.FindWithTag("Player1");
        manager = GameObject.FindWithTag("Manager");
        kusodas = GameObject.Find("Kusodas");
	}

    public void Update()
    {
        mx = transform.position.x;
        my = transform.position.y;
        ex = enemy.transform.position.x;
        ey = enemy.transform.position.y;

        //ロジック変更
        mtime--;
        if (mtime <= 0)
        {
            mtime = Random.Range(50, 100);
            maai = Random.Range(2, 10);  //間合いの距離
            hani = Random.Range(4, 8);	//敵察知の距離
            if(ComonScript.nanid == 0)
            {
                maai = Random.Range(5, 10);
                hani = Random.Range(10, 15);
            }
        }

        if (dead == false)
        {
            if(ComonScript.nanid != 3){
            if (jump == true)
            {
                if (Mathf.Abs(mx - ex) > maai || (30 - Mathf.Abs(mx - ex) < maai))
                {
                    Move(true, 0.07f);     //間合いより遠い
                }
                else if (Mathf.Abs(mx - ex) < maai || 30 - Mathf.Abs(mx - ex) > maai)
                {
                    Move(false, 0.07f);    //間合いより近い
                }
            }
            //敵察知
            if (((mx < ex + hani) && (mx > ex - hani)) || (30 - Mathf.Abs(mx - ex) < hani))
            {
                //Debug.Log(Mathf.Abs(mx - ex));
                //ショット機能
                if (my > ey + 1)
                {
                    if (Sroop > 8)
                    {
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
                }
                else if ((my <= ey + 2) && (my >= ey - 1) && (jump == true) && (jtime <= 0))
                {
                    Jump();
                //逃げる
                }else if (my < ey - 0.8)
                //else if ((my < ey - 0.8) && (TitleScript.selectmode == 5))
                {
                    //難易度分岐
                    if(ComonScript.nanid == 1)
                        Move(false, 0.02f);
                    if(ComonScript.nanid == 2)
                        Move(false, 0.05f);
                    print("特別逃げシステム");
                }
            }}
        }
        else
        {
           //Handheld.Vibrate ();
           ComonScript.Shaking();
			kusodas.GetComponent<ShotManageScript>().Fire(15, -2, transform.position, new Vector2(Random.Range(-8.0f,8.0f),Random.Range(4.0f,16.0f)), Kuso.GetComponent<ShotScript>());
			t++;
			if (t == 100){
				for (t=100;t<180;t++){
                    kusodas.GetComponent<ShotManageScript>().Fire(15, -2, transform.position, new Vector2(Random.Range(-8.0f,8.0f),Random.Range(4.0f,16.0f)), Kuso.GetComponent<ShotScript>());
                }
                Destroy(gameObject);
            }
        }

            //向き
        if (mx < ex)
        {
            toward = 1;
        }
        else
        {
            toward = -1;
        }

            //ジャンプ猶予
        if (jtime >= 0)
            jtime--;

            /*
                    float mx1 = Input.GetAxis("Horizontal");
                    if (dead == false){
                        if (jump == true){

                            if (Input.GetButtonUp("Jump")){
                                Jump();
                            }
                            transform.position += new Vector3(mx1*0.05f,0,0);
                        }
                        if (Input.GetButtonUp("Fire1"))
                            Shot();
                    }
            */
        
    }

    void Shot (int id) {
        auso.PlayOneShot(bomb);
        manager.GetComponent<ShotManageScript>().Fire(id, -1, transform.position, new Vector2(0,0), Bullet.GetComponent<ShotScript>());
    }

	void Jump () {
        //自殺防止
        //if (((mx<=15)&&(toward == -1))||((mx>=-15)&&(toward == 1))){
        //難易度分岐
        auso.PlayOneShot(pyon);
        if(ComonScript.nanid == 0)
            rb2d.AddForce(new Vector2(toward * 2.5f, 5) * 100);
        if(ComonScript.nanid == 1)
            rb2d.AddForce(new Vector2(toward * 3.5f, 7) * 100);
        if(ComonScript.nanid == 2)
            rb2d.AddForce(new Vector2(toward * 4.5f, 7) * 100);
		jump = false;
		//}
	}

	void Death () {
        if(dead == false)
            auso.PlayOneShot(bobobo);
        rb2d.isKinematic = false;
		dead = true;
	}

	void Move (bool x,float y) {
		if (x == true){			//進む
			if (toward == 1){	//右向き
				transform.position += Vector3.right * y;
			}else{				//左向き
				transform.position += Vector3.left * y;
			}
		}else{					//戻る
			if (toward == 1){	//右向き
				transform.position += Vector3.left * y;
			}else{				//左向き
				transform.position += Vector3.right * y;
			}
		}
	}

    //地面との接触判定
	void OnCollisionEnter2D (Collision2D obj) {
        if (obj.gameObject.name != "Head") {
            auso.PlayOneShot(tyakuti);
            if ((dead == false)&&(obj.gameObject.tag == "ground")){
                jump = true;
                if(ComonScript.nanid == 0)
                    jtime = Random.Range (30,50);
                if(ComonScript.nanid == 1)
                    jtime = Random.Range (15,35);
                if(ComonScript.nanid == 2)
                    jtime = 0;
            }
        }
	}

    void OnTriggerEnter2D(Collider2D obj)
    {
        var projectile = obj.GetComponent<ShotScript>();
        if (obj.gameObject.name == "WarpL")
        {
            transform.position += Vector3.right * 25.0f;
            //rb2d.velocity = new Vector3(rb2d.velocity.x, rb2d.velocity.y, 0);
        }
        if (obj.gameObject.name == "WarpR")
        {
            transform.position += Vector3.left * 25.0f;
            //rb2d.velocity = new Vector3(rb2d.velocity.x, rb2d.velocity.y, 0);
        }else if (obj.gameObject.name == "Death"){
			Destroy(gameObject);
		}
        if (projectile.OwnerId != -1) {
            Death();
        }
    }
}
