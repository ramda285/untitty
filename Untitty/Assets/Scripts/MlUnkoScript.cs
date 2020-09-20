using System.Collections.Generic;
using UnityEngine;
using Unity.MLAgents;
using Unity.MLAgents.Sensors;

public class MlUnkoScript : Agent
{
    Rigidbody2D rb2d;
    public GameObject ShotM;
    public GameObject enemy;
    MlUnkoScript eneml;
    public bool jump;
    public float mx;
    int toward;
    int projectileId;
    int number;
    float Sroop;
    Vector2 distance;
    public float time;
    public float point = 0;//後で消す

    void Start(){
        rb2d = GetComponent<Rigidbody2D>();
        ShotM = GameObject.FindWithTag("Manager").transform.GetChild(0).gameObject;
        eneml = enemy.GetComponent<MlUnkoScript>();
    }

    public override void OnEpisodeBegin(){
        //ループ開始時に読み込まれる
        if(gameObject.name == "CharaML1"){
            transform.localPosition = new Vector3(7f, 7f, -1f);
            number = 1;
        }else{
            transform.localPosition = new Vector3(-7f, 7f, -1f);
            number = 2;
        }
        rb2d.velocity = Vector3.zero;
        jump = false;
        mx = 0;
        time = 0;
    }

    public override void CollectObservations(VectorSensor sensor){
        //sensor.AddObservationを入れまくる
        sensor.AddObservation(transform.position.x);
        sensor.AddObservation(transform.position.y);
        sensor.AddObservation(distance);
        sensor.AddObservation(rb2d.velocity);
        sensor.AddObservation(enemy.GetComponent<Rigidbody2D>().velocity);
    }

    public override void OnActionReceived(float[] vectorAction){
        distance.x = transform.position.x - enemy.transform.position.x;
        distance.y = transform.position.y - enemy.transform.position.y;
        if(ShotManageScript.shotdeath) ShotManageScript.shotdeath = false;
        time += Time.deltaTime * 60f;
        mx = vectorAction[0];
        if (mx > 0f){
			toward = 1;
		}else if (mx < 0f){
			toward = -1;
		}
        if(vectorAction[2] > 0.5f){
            if (Sroop > 8f){
                ShotM.GetComponent<ShotManageScript>().Fire(projectileId++, number, transform.position, new Vector2(0,0));
                Sroop = 0;
            }
        }
        Sroop += Time.deltaTime * 60f;
        if (jump){
			transform.position += Vector3.right * mx * 4.7f * Time.deltaTime;
            if(vectorAction[1] > 0.5f){
                if(toward == 1){
                    if(distance.x > 0){
                        if(Mathf.Abs(distance.x) < 12f){
                            Jumper(false);
                        }else{
                            Jumper(true);
                        }
                    }else{
                        if(Mathf.Abs(distance.x) < 12f){
                            Jumper(true);
                        }else{
                            Jumper(false);
                        }
                    }
                }else{
                    if(distance.x > 0){
                        if(Mathf.Abs(distance.x) < 12f){
                            Jumper(true);
                        }else{
                            Jumper(false);
                        }
                    }else{
                        if(Mathf.Abs(distance.x) < 12f){
                            Jumper(false);
                        }else{
                            Jumper(true);
                        }
                    }
                }
		        jump = false;
            }
		}
        if (time >= 5000){
            print("arare");
            SetReward(-1.0f);
            EndEpisode();
            time = 0;
        }

        //敵に近いポジションで敵より高い位置にいるとリワード 
        //→自分で書いておいてそれじゃ勝てないことに気づいた
        //→敵に近い位置でジャンプ or カウンタージャンプ
        /*
        if (distancex < 5){
            if(distancey > 0){
                point += Mathf.Pow(2,(-1*Mathf.Pow(Mathf.Abs(distancex),2)))/180f;
            }else if(distancey < 0){
                point -= Mathf.Pow(2,(-1*Mathf.Pow(Mathf.Abs(distancex,2))/2))/180f;
            }
        }
        if ((24 - distancex) < 5){
            if(distancey > 0){
                point += Mathf.Pow(2,(-1*Mathf.Pow((24 - Mathf.Abs(distancex)),2)))/180f;
            }else if(distancey < 0){
                point -= Mathf.Pow(2,(-1*Mathf.Pow((24 - Mathf.Abs(distancex)),2)/2))/180f;
            }
        }
        */
    }

    public override void Heuristic(float[] actionsOut){
        //AIの取れる行動
        actionsOut[0] = Input.GetAxis("Horizontal");
        actionsOut[1] = Input.GetKey(KeyCode.UpArrow) ? 1f : 0f;
        actionsOut[2] = Input.GetKey(KeyCode.DownArrow) ? 1f : 0f;
    }

    //地面との接触判定
	void OnCollisionEnter2D (Collision2D obj) {
		if (obj.gameObject.tag == "ground"){
            jump = true;
        }
		if(Mathf.Abs(GetComponent<Rigidbody2D>().velocity.y) < 1f){
			GetComponent<Rigidbody2D>().velocity = new Vector2(GetComponent<Rigidbody2D>().velocity.x,0);
		}
	}

    void Jumper(bool pn){
        if(pn){
            rb2d.AddForce(new Vector2(toward * 4.5f, 6) * 100);
            if (distance.x < 5f){
                point = Mathf.Pow(2f,(-1*Mathf.Pow(Mathf.Abs(distance.x),1.5f)))/18f;
            }else if ((24f - distance.x) < 5f){
                point = Mathf.Pow(2f,(-1*Mathf.Pow(Mathf.Abs(24 - distance.x),1.5f)))/18f;
            }
        }else{
            rb2d.AddForce(new Vector2(toward * 3f, 5) * 100);

        }
    }

    void OnTriggerEnter2D(Collider2D obj){
        if (obj.gameObject.tag == "Bullet"){
            var projectile = obj.GetComponent<ShotScript>();
            if (projectile.OwnerId != number) {
                ShotManageScript.shotdeath = true;
                print(gameObject.name + "kill");
                //print("point is "+point);
                SetReward(-1.0f);
                eneml.SetReward(1.0f);
                EndEpisode();
                eneml.EndEpisode();
            }
        }else{
            if (obj.gameObject.name == "WarpL"){
                transform.position += Vector3.right * 24.5f;
            }
            if (obj.gameObject.name == "WarpR"){
                transform.position += Vector3.left * 24.5f;
            }else if (obj.gameObject.name == "Death"){
                SetReward(-1.0f);
                EndEpisode();
                eneml.EndEpisode();
            }
        }
    }
}