using System.Collections.Generic;
using UnityEngine;
using Unity.MLAgents;
using Unity.MLAgents.Sensors;

public class MlUnkoScript : Agent
{
    Rigidbody2D rb2d;
    public GameObject ShotM;
    public GameObject enemy;
    bool jump;
    public float mx;
    int toward;
    int projectileId;
    int number;
    float Sroop;

    void Start(){
        rb2d = GetComponent<Rigidbody2D>();
        ShotM = GameObject.FindWithTag("Manager").transform.GetChild(0).gameObject;
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
        jump = false;
        mx = 0;
    }

    public override void CollectObservations(VectorSensor sensor){
        //sensor.AddObservationを入れまくる
        sensor.AddObservation(this.transform.localPosition);
        sensor.AddObservation(enemy.transform.localPosition);
        sensor.AddObservation(rb2d.velocity.x);
        sensor.AddObservation(rb2d.velocity.y);
    }

    public override void OnActionReceived(float[] vectorAction){
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
			transform.position += Vector3.right * mx * 6f * Time.deltaTime;
            if(vectorAction[1] > 0.5f){
                rb2d.AddForce(new Vector2(toward * 3.5f, 7) * 100);
		        jump = false;
            }
		}
    }

    public override void Heuristic(float[] actionsOut){
        //AIの取れる行動
        actionsOut[0] = Input.GetAxis("Horizontal");
        actionsOut[1] = Input.GetKey(KeyCode.W) ? 1f : 0f;
        actionsOut[2] = Input.GetKey(KeyCode.S) ? 1f : 0f;
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

    void OnTriggerEnter2D(Collider2D obj){
        var projectile = obj.GetComponent<ShotScript>();
        if (obj.gameObject.name == "WarpL"){
            transform.position += Vector3.right * 24.5f;
        }
        if (obj.gameObject.name == "WarpR"){
            transform.position += Vector3.left * 24.5f;
        }else if (obj.gameObject.name == "Death"){
			SetReward(-1.0f);
            EndEpisode();
		}
        if (projectile.OwnerId != number) {
            SetReward(-1.0f);
            enemy.GetComponent<MlUnkoScript>().SetReward(1.0f);
            EndEpisode();
        }
    }
}