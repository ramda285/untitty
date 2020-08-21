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