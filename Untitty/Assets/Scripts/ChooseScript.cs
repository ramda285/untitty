<<<<<<< HEAD
﻿using UnityEngine;
using UnityEngine.UI;

public class ChooseScript : MonoBehaviour
{
    //パネルスイッチ
    bool dl;
    //選んだキャラ
    public static int chara;
    private int scene;
    public GameObject nameg, specialg, modoru, flash;
    public float aglx,jmpx,atkx;
    RectTransform rect;
    private Text name, special;
    float toward;
    float moves;
    int t,fc;
    public bool n,n2;       //頭悪いスイッチ管理
    new private AudioSource audio;
    public AudioClip select, kime;
    // Start is called before the first frame update
    void Start()
    {
        dl = false;
        n = false;
        n2 = true;
        t = 50;
        fc = 0;
        chara = 64;
        moves = 0;
        toward = 1;
        audio = GetComponent<AudioSource>();
        name = nameg.GetComponent<Text> ();
        special = specialg.GetComponent<Text> ();
        rect = GetComponent<RectTransform>();
=======
﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChooseScript : MonoBehaviour
{
    bool dl;
    public static int chara;
    int n;       //頭悪いスイッチ管理
    private AudioSource audio;
    // Start is called before the first frame update
    void Start()
    {
        n=0;
        audio = GetComponent<AudioSource>();
>>>>>>> origin/master
    }

    // Update is called once per frame
    void Update()
    {
<<<<<<< HEAD
        ComonScript.Getting(dl,scene);
        
        //フラッシュ
        flash.GetComponent<SpriteRenderer>().color = new Color(255,255,255,fc/20f);
        if(n == true){
            fc--;
        }
        //移動距離
        if(t>=0){
            GestureScript.flick = 0;
            moves = 5f * Mathf.Sin(t/19.385f * toward);
            t--;
        }else{
            n2 = false;
        }

        //回転
        transform.Rotate(new Vector3(0f,1000f,0), moves);
        //フリック反応
        if (n2 == false){
            if(GestureScript.flick == -1 || Input.GetKeyDown (KeyCode.RightArrow)){
                t = 19;
                toward = 1;
                chara++;
                n2 = true;
                audio.PlayOneShot(select);
            }
            if(GestureScript.flick == 1 || Input.GetKeyDown (KeyCode.LeftArrow)){
                t = 19;
                toward = -1;
                chara--;
                n2 = true;
                audio.PlayOneShot(select);
            }
        }

        switch(chara%8){
            case 0:
                name.text = "ウンコボーイ";
                special.text = "一番オーソドックス\nジャンプは高く移動は遅い";
                aglx = 0.3f;
                jmpx = 0.6f;
                atkx = 0.5f;
                break;
            case 1:
                name.text = "ブリリーヌ";
                special.text = "ウンコボーイより早いが\nその分飛距離が低い";
                aglx = 0.6f;
                jmpx = 0.5f;
                atkx = 0.6f;
                break;
            case 2:
                name.text = "フンデルセン";
                special.text = "早く移動し高く飛ぶが\n遠くには跳べない";
                aglx = 0.9f;
                jmpx = 0.8f;
                atkx = 0.2f;
                break;
            case 3:
                name.text = "ゲーリー";
                special.text = "能力は低めだが\n2段ジャンプができる";
                aglx = 0.3f;
                jmpx = 0.9f;
                atkx = 0.7f;
                break;
            case 4:
                name.text = "ゲリクソンＪｒ．";
                special.text = "良く跳ねるので\n積極的に跳ぼう";
                aglx = 0.4f;
                jmpx = 0.3f;
                atkx = 0.8f;
                break;
            case 5:
                name.text = "ナガシマ＝ショウ";
                special.text = "空中でもわずかに\n移動ができる";
                aglx = 0.7f;
                jmpx = 0.5f;
                atkx = 0.5f;
                break;
            case 6:
                name.text = "スカラベ";
                special.text = "弾を上に打つため\n下からでも勝てるかも";
                aglx = 0.7f;
                jmpx = 0.4f;
                atkx = 0.5f;
                break;
            case 7:
                name.text = "ベンザスキー";
                special.text = "移動は鈍重だけど\nと重いので隙が少ない";
                aglx = 0.2f;
                jmpx = 0.4f;
                atkx = 0.3f;
                break;
            default:
                break;
        }

        if (modoru.GetComponent<ButtonScript>().button == true){
            ComonScript.Getting(true,0);
            ComonScript.Getting(true,0);
        }

        if(GestureScript.tap == 1 && n==false){
            dl = true;
            fc = 20;
            audio.PlayOneShot(kime);
            n = true;
            if (TitleScript.minnamode){
                scene = 4;
            }else{
                scene = 3;
            }
            //光らせるぞー ひかった
=======
        ComonScript.Getting(dl,3);
        if(GestureScript.tap == 1 && n==0){
            dl = true;
            audio.Play();
            n=1;
            print(chara);
>>>>>>> origin/master
        }
    }
}
