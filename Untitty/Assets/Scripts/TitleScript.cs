﻿using UnityEngine.SceneManagement;
using UnityEngine;
using UnityEngine.UI;
using Photon.Pun;

public class TitleScript : MonoBehaviourPunCallbacks {
    float t;      //文字の回転、
    bool dl;         //明るくする
    public static bool bonse;       //爆発音
    public int kusofall = 0;       //くそを落とす時間
    public static int kusosum = 0;      //くその合計
    static bool first = false;  //インサート文の表示
    private int scene = 2;      //シーン遷移
    public static bool minnamode = false;   //オンラインbool
    public GameObject hitori, minna, config, insart;    //各ボタン
    public GameObject ComonO;   //ComonGameObject
    public GameObject Kuso;
    public AudioSource audio;
    public AudioSource bon;
    //selectmodeについて・・・0,ひとり　1,みんな　2,コンフィグ

	// Use this for initialization
	void Start () {
        Application.targetFrameRate = 60;
        if(PlayerPrefs.GetInt("Tutorial") != 1){
            SceneManager.LoadScene(6);
        }
        if(GameObject.Find("Comon(Clone)") == null){
            Instantiate(ComonO);
        }
        //チュートリアルに飛ぶ
        //PlayerPrefs.DeleteAll();
        PhotonNetwork.ConnectUsingSettings();
        audio = GetComponent<AudioSource>();
        bon = GetComponent<AudioSource>();
        bonse = false;
        t = 30;
        dl = false;
	}
	
	// Update is called once per frame
	void Update () {
        ComonScript.Getting(dl,scene);
        //ウンチを降らせる
        kusofall--;
        if (kusofall < 0){
            Instantiate(Kuso, new Vector3(0, 8, 0), Quaternion.identity);
            kusofall = Random.Range(500,1200);
            kusosum++;
        }
        if (bonse){
            bonse = false;
            bon.Play();
        }

        //タイトルボタン
        if (first){
            if(insart != null){
                Destroy(insart);
            }
            if(t >= 0){
                t--;
                hitori.transform.Rotate(0,-3f,0);
                minna.transform.Rotate(0,-3f,0);
                config.transform.Rotate(0,-3f,0);
            }
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
    void PlaySE(int n){
        if(n==1)
        audio.Play();
    }

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
