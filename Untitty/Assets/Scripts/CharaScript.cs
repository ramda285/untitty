using System.Collections;
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
