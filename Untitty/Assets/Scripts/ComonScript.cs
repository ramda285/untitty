using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement; 
using UnityEngine;
using UnityEngine.UI;

public class ComonScript : MonoBehaviour
{
    public bool DontDestroyEnabled = true;
    public static GameObject panel;
    static float a;

    // Use this for initialization
    void Start () {
        a = 1;
        panel = GameObject.Find("Panel");
        transform.SetAsLastSibling();
        if (DontDestroyEnabled)
            DontDestroyOnLoad (this);
    }
	
	// ＥＳＣによるゲーム終了と画面のフェードイン、アウトを行う
	void Update () {
		if (Input.GetButtonDown ("Cancel")){
			if (SceneManager.GetActiveScene().name == "title"){
				Application.Quit();
				Debug.Log (SceneManager.GetActiveScene().name);
			}else{
                Getting(true, 0);
			}
		}
	}

    //trueで暗転、falseでフェードイン
    public static void Getting(bool dl, int scene){
        if (dl){
            a += 0.03f;
            panel.GetComponent<Image>().color = new Color(0, 0, 0, a);
            if (a >= 1)
                SceneManager.LoadScene(scene);
        }else if(a > 0){
            a -= 0.03f;
            panel.GetComponent<Image>().color = new Color(0, 0, 0, a);
        }
    }
}
