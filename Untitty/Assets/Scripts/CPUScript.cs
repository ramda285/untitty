using System.Collections;
using System.Collections.Generic;
using UnityEngine;

<<<<<<< HEAD
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
=======
public class CPUScript : MonoBehaviour {

	public Rigidbody2D rb2d;
	public GameObject Bullet;
	public GameObject enemy;
	public GameObject Kuso;
	public GameObject hisan;
    public AudioSource pyon;
    public AudioSource tyakuti;
    public AudioSource bomb;
    public AudioSource bobobo;
    public float mx,my,ex,ey;
    public static string difimode;

    public bool jump = false , dead = false , niges = false;
	public int toward = 1;	//向き
	public int Sroop = 0;	//発射速度
	public int jtime = 0;	//ジャンプ猶予
	public int maai = 0; //間合い
    public int mtime = 0; //間合い変更
	public int hani = 10;	//敵察知範囲
>>>>>>> origin/master
	int t;

	void Start () {
		rb2d = GetComponent<Rigidbody2D>();
<<<<<<< HEAD
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
=======
        //enemy = GameObject.Find("CharaA");
        enemy = BattleScript.Playercl;
	}

    void Update()
    {
        float mx = transform.position.x;
        float my = transform.position.y;
        float ex = enemy.transform.position.x;
        float ey = enemy.transform.position.y;
>>>>>>> origin/master

        //ロジック変更
        mtime--;
        if (mtime <= 0)
        {
            mtime = Random.Range(50, 100);
            maai = Random.Range(2, 10);  //間合いの距離
            hani = Random.Range(4, 8);	//敵察知の距離
<<<<<<< HEAD
            if(ComonScript.nanid == 0)
=======
            if (TitleScript.selectmode == 4)
>>>>>>> origin/master
            {
                maai = Random.Range(5, 10);
                hani = Random.Range(10, 15);
            }
        }

        if (dead == false)
        {
<<<<<<< HEAD
            if(ComonScript.nanid != 3){
=======
>>>>>>> origin/master
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
<<<<<<< HEAD
                        Shot(++projectileId);
                        //難易度分岐
                        if (ComonScript.nanid == 0)
                            Sroop -= 15;
                        if (ComonScript.nanid == 1)
                            Sroop -= 10;
                        if (ComonScript.nanid == 2)
                            Sroop -= 5;
=======
                        Shot();
                        Sroop -= 8;
                        if (TitleScript.selectmode == 4)
                        {
                            Sroop -= 3;
                        }
>>>>>>> origin/master
                    }
                    Sroop++;
                //ジャンプ
                }
                else if ((my <= ey + 2) && (my >= ey - 1) && (jump == true) && (jtime <= 0))
                {
                    Jump();
                //逃げる
<<<<<<< HEAD
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
=======
                }
                else if ((my < ey - 0.8) && (TitleScript.selectmode == 5))
                {
                    Move(false, 0.05f);
                }
            }
        }
        else
        {
            Debug.Log("aaaa");
            hisan = Instantiate(Kuso, transform.position, Quaternion.identity) as GameObject;
            hisan.GetComponent<Rigidbody2D>().AddForce(new Vector2(Random.Range(-400.0f, 400.0f), Random.Range(200.0f, 800.0f)));
            t++;
            if (t == 100)
            {
                for (t = 100; t < 180; t++)
                {
                    hisan = Instantiate(Kuso, transform.position, Quaternion.identity) as GameObject;
                    hisan.GetComponent<Rigidbody2D>().AddForce(new Vector2(Random.Range(-400.0f, 400.0f), Random.Range(200.0f, 800.0f)));
>>>>>>> origin/master
                }
                Destroy(gameObject);
            }
        }

            //向き
<<<<<<< HEAD
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
=======
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
>>>>>>> origin/master

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

<<<<<<< HEAD
    void Shot (int id) {
        auso.PlayOneShot(bomb);
        manager.GetComponent<ShotManageScript>().Fire(id, -1, transform.position, new Vector2(0,0), Bullet.GetComponent<ShotScript>());
    }
=======
	void Shot () {
        bomb.PlayOneShot(bomb.clip);
        GameObject shot = Instantiate (Bullet,transform.position,Quaternion.identity) as GameObject;
		shot.tag = "ShotB";
	}
>>>>>>> origin/master

	void Jump () {
        //自殺防止
        //if (((mx<=15)&&(toward == -1))||((mx>=-15)&&(toward == 1))){
<<<<<<< HEAD
        //難易度分岐
        auso.PlayOneShot(pyon);
        if(ComonScript.nanid == 0)
            rb2d.AddForce(new Vector2(toward * 2.5f, 5) * 100);
        if(ComonScript.nanid == 1)
            rb2d.AddForce(new Vector2(toward * 3.5f, 7) * 100);
        if(ComonScript.nanid == 2)
            rb2d.AddForce(new Vector2(toward * 4.5f, 7) * 100);
		jump = false;
=======
        if (TitleScript.selectmode == 4)
        {
            rb2d.AddForce(new Vector2(toward * 2.5f, 5) * 100);
        }
        else {
            rb2d.AddForce(new Vector2(toward * 3.5f, 7) * 100);
        }
			jump = false;
>>>>>>> origin/master
		//}
	}

	void Death () {
<<<<<<< HEAD
        if(dead == false)
            auso.PlayOneShot(bobobo);
        rb2d.isKinematic = false;
=======
        bobobo.PlayOneShot(bobobo.clip);
        rb2d.isKinematic = false;
		Debug.Log ("Shindayo");
>>>>>>> origin/master
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

<<<<<<< HEAD
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
=======
	void OnCollisionEnter2D (Collision2D obj) {
        tyakuti.PlayOneShot(tyakuti.clip);
        if ((dead == false)&&(obj.gameObject.tag == "ground")){
			jump = true;
			jtime = Random.Range (15,35);
            if (TitleScript.selectmode == 4) {
                jtime = Random.Range(55, 75);
            }
			if (my<ey){
				niges = true;
			}
		}else{
			jump = false;
		}
>>>>>>> origin/master
	}

    void OnTriggerEnter2D(Collider2D obj)
    {
<<<<<<< HEAD
        var projectile = obj.GetComponent<ShotScript>();
        if (obj.gameObject.name == "WarpL")
        {
            transform.position += Vector3.right * 25.0f;
=======
        if (obj.gameObject.name == "WarpL")
        {
            transform.position += Vector3.right * 27.0f;
>>>>>>> origin/master
            //rb2d.velocity = new Vector3(rb2d.velocity.x, rb2d.velocity.y, 0);
        }
        if (obj.gameObject.name == "WarpR")
        {
<<<<<<< HEAD
            transform.position += Vector3.left * 25.0f;
            //rb2d.velocity = new Vector3(rb2d.velocity.x, rb2d.velocity.y, 0);
        }else if (obj.gameObject.name == "Death"){
			Destroy(gameObject);
		}
        if (projectile.OwnerId != -1) {
            Death();
=======
            transform.position += Vector3.left * 27.0f;
            //rb2d.velocity = new Vector3(rb2d.velocity.x, rb2d.velocity.y, 0);
>>>>>>> origin/master
        }
    }
}
