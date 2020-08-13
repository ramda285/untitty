<<<<<<< HEAD
﻿using UnityEngine.SceneManagement; 
=======
﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement; 
>>>>>>> origin/master
using UnityEngine;
using UnityEngine.UI;

public class ComonScript : MonoBehaviour
{
    public bool DontDestroyEnabled = true;
    public static GameObject panel;
<<<<<<< HEAD
    static float a,x;
    public static float kando = 1.0f;
    public static int nanid = 1;

    // Use this for initialization
    void Awake () {
        a = 1;
        x = 0;
        panel = GameObject.Find("Panel");
        transform.SetAsLastSibling();
        DontDestroyOnLoad (this);
=======
    static float a;

    // Use this for initialization
    void Start () {
        a = 1;
        panel = GameObject.Find("Panel");
        transform.SetAsLastSibling();
        if (DontDestroyEnabled)
            DontDestroyOnLoad (this);
>>>>>>> origin/master
    }
	
	// ＥＳＣによるゲーム終了と画面のフェードイン、アウトを行う
	void Update () {
<<<<<<< HEAD
		if (Input.GetKeyDown(KeyCode.Escape)){
=======
		if (Input.GetButtonDown ("Cancel")){
>>>>>>> origin/master
			if (SceneManager.GetActiveScene().name == "title"){
				Application.Quit();
				Debug.Log (SceneManager.GetActiveScene().name);
			}else{
<<<<<<< HEAD
                ComonScript.Getting(true, 0);
			}
		}
        Camera.main.transform.position = new Vector3(Random.Range(-1*x,x), Random.Range(-1*x,x),-10);
        if(x>0){
            x -= 0.005f;
        }else{
            x=0;
        }
=======
                Getting(true, 0);
			}
		}
>>>>>>> origin/master
	}

    //trueで暗転、falseでフェードイン
    public static void Getting(bool dl, int scene){
        if (dl){
<<<<<<< HEAD
            a += Time.deltaTime;
=======
            a += 0.03f;
>>>>>>> origin/master
            panel.GetComponent<Image>().color = new Color(0, 0, 0, a);
            if (a >= 1)
                SceneManager.LoadScene(scene);
        }else if(a > 0){
<<<<<<< HEAD
            a -= Time.deltaTime;
            panel.GetComponent<Image>().color = new Color(0, 0, 0, a);
        }
    }

    public static void Shaking(){
        x = 0.3f;
    }
=======
            a -= 0.03f;
            panel.GetComponent<Image>().color = new Color(0, 0, 0, a);
        }
    }
>>>>>>> origin/master
}
