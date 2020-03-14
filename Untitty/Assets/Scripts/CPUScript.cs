using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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
	int t;

	void Start () {
		rb2d = GetComponent<Rigidbody2D>();
        //enemy = GameObject.Find("CharaA");
        enemy = BattleScript.Playercl;
	}

    void Update()
    {
        float mx = transform.position.x;
        float my = transform.position.y;
        float ex = enemy.transform.position.x;
        float ey = enemy.transform.position.y;

        //ロジック変更
        mtime--;
        if (mtime <= 0)
        {
            mtime = Random.Range(50, 100);
            maai = Random.Range(2, 10);  //間合いの距離
            hani = Random.Range(4, 8);	//敵察知の距離
            if (TitleScript.selectmode == 4)
            {
                maai = Random.Range(5, 10);
                hani = Random.Range(10, 15);
            }
        }

        if (dead == false)
        {
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
                        Shot();
                        Sroop -= 8;
                        if (TitleScript.selectmode == 4)
                        {
                            Sroop -= 3;
                        }
                    }
                    Sroop++;
                //ジャンプ
                }
                else if ((my <= ey + 2) && (my >= ey - 1) && (jump == true) && (jtime <= 0))
                {
                    Jump();
                //逃げる
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

	void Shot () {
        bomb.PlayOneShot(bomb.clip);
        GameObject shot = Instantiate (Bullet,transform.position,Quaternion.identity) as GameObject;
		shot.tag = "ShotB";
	}

	void Jump () {
        //自殺防止
        //if (((mx<=15)&&(toward == -1))||((mx>=-15)&&(toward == 1))){
        if (TitleScript.selectmode == 4)
        {
            rb2d.AddForce(new Vector2(toward * 2.5f, 5) * 100);
        }
        else {
            rb2d.AddForce(new Vector2(toward * 3.5f, 7) * 100);
        }
			jump = false;
		//}
	}

	void Death () {
        bobobo.PlayOneShot(bobobo.clip);
        rb2d.isKinematic = false;
		Debug.Log ("Shindayo");
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
	}

    void OnTriggerEnter2D(Collider2D obj)
    {
        if (obj.gameObject.name == "WarpL")
        {
            transform.position += Vector3.right * 27.0f;
            //rb2d.velocity = new Vector3(rb2d.velocity.x, rb2d.velocity.y, 0);
        }
        if (obj.gameObject.name == "WarpR")
        {
            transform.position += Vector3.left * 27.0f;
            //rb2d.velocity = new Vector3(rb2d.velocity.x, rb2d.velocity.y, 0);
        }
    }
}
