<<<<<<< HEAD
﻿using UnityEngine.SceneManagement;
using UnityEngine;
using UnityEngine.UI;
using Photon.Pun;

public class TitleScript : MonoBehaviourPunCallbacks {
    float t;      //文字の回転、
    bool dl;         //明るくする
    static bool first = false;  //インサート文の表示
    private int scene = 2;      //シーン遷移
    public static bool minnamode = false;   //オンラインbool
    public GameObject hitori, minna, config, insart;    //各ボタン
    public GameObject ComonO;   //ComonGameObject
    new AudioSource audio;
=======
﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEngine;
using UnityEngine.UI;

public class TitleScript : MonoBehaviour {
    float t, t2 = 44;      //文字の回転、
    bool dl;         //明るくする
    bool first;
    int scene;      //シーン遷移
    int n,n2;       //頭悪いスイッチ管理
    GameObject screen;
    public GameObject hitori, minna, config, insart;
    public static int selectmode;
    static public AudioClip sentaku,kime;
    private AudioSource audio;
>>>>>>> origin/master
    //selectmodeについて・・・0,ひとり　1,みんな　2,コンフィグ

	// Use this for initialization
	void Start () {
<<<<<<< HEAD
        if(PlayerPrefs.GetInt("Tutorial") != 1){
            SceneManager.LoadScene(6);
        }
        if(GameObject.Find("Comon(Clone)") == null){
            Instantiate(ComonO);
        }
        //PlayerPrefs.DeleteAll();
        PhotonNetwork.ConnectUsingSettings();
        audio = GetComponent<AudioSource>();
        t = 30;
        dl = false;
=======
		screen = GameObject.Find("Screen");
        audio = GetComponent<AudioSource>();
        t = 30;
        dl = false;
        first = false;
        n2=1;
>>>>>>> origin/master
	}
	
	// Update is called once per frame
	void Update () {
        ComonScript.Getting(dl,scene);
<<<<<<< HEAD
        if (first){
            if(insart != null){
                Destroy(insart);
=======
        if(Input.GetMouseButtonDown(0))
            first = true;
        if (first){
            if(insart != null){
                Destroy(insart);
                n=1;
>>>>>>> origin/master
            }
            if(t >= 0){
                t--;
                hitori.transform.Rotate(0,-3f,0);
                minna.transform.Rotate(0,-3f,0);
                config.transform.Rotate(0,-3f,0);
            }
<<<<<<< HEAD
            if(hitori.GetComponent<ButtonScript>().button == true){
                hitori.GetComponent<ButtonScript>().button = false;
                dl = true;
                scene = 1;
                minnamode = false;
                audio.Play();
            }
            if(minna.GetComponent<ButtonScript>().button == true){
                minna.GetComponent<ButtonScript>().button = false;
                dl = true;
                scene = 1;
                minnamode = true;
                audio.Play();
            }
            if(config.GetComponent<ButtonScript>().button == true){
                config.GetComponent<ButtonScript>().button = false;
                dl = true;
                scene = 2;
                minnamode = false;
                audio.Play();
            }
            return;
        }
        
        if(Input.GetMouseButtonDown(0) || GameObject.Find("Zengamen").GetComponent<ButtonScript>().button == true){
            if(first == false){
                audio.Play();
                first = true;
            }
        }
    }


/*過去の設定(文化祭用四人プレイ)
=======
            if(n2==1){
                if(hitori.GetComponent<ButtonScript>().button == true){
                    dl = true;
                    scene = 1;
                    n=1;
                    n2=0;
                }
                if(minna.GetComponent<ButtonScript>().button == true){
                    dl = true;
                    scene = 1;
                    n=1;
                    n2=0;
                }
                if(config.GetComponent<ButtonScript>().button == true){
                    dl = true;
                    scene = 2;
                    n=1;
                    n2=0;
                }
            }
            
        }
        PlaySE(n);
        n=0;
    }

>>>>>>> origin/master
    void PlaySE(int n){
        if(n==1)
        audio.Play();
    }

<<<<<<< HEAD
=======
/* 
>>>>>>> origin/master
    void secondchoice() {
        if (t2 >= 0) {
            hitori.transform.Rotate(0, 0, 0);
            minna.transform.Rotate(0, 0, 0);
            config.transform.Rotate(0, 0, 0);
            t2 -= 1;
        }
        switch (Mathf.Abs(choice) % 3)
        {
            case 0:
                gameObject.transform.position = new Vector3(-11f, -4.5f, -1);
                if (Input.GetButtonUp("Jump"))
                {
                    kime.PlayOneShot(kime.clip);
                    button = true;
                    if(selectmode == 0){
                        selectmode = 4;
                    }else{
                        selectmode = 1;
                    }
                }
            break;
            case 1:
                gameObject.transform.position = new Vector3(-4f, -4.5f, -1);
                if (Input.GetButtonUp("Jump"))
                {
                    kime.PlayOneShot(kime.clip);
                    button = true;
                    if(selectmode == 1){
                        selectmode = 5;
                    }else{
                        selectmode = 2;
                    }
                }
            break;
            case 2:
                gameObject.transform.position = new Vector3(5f, -4.5f, -1);
                if (Input.GetButtonUp("Jump"))
                {
                    kime.PlayOneShot(kime.clip);
                    button = true;
                    if(selectmode == 0){
                        selectmode = 6;
                    }else{
                        selectmode = 3;
                    }
                }
            break;
            default:
                break;
        }
    }*/
}
