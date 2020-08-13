using UnityEngine.SceneManagement; 
using UnityEngine;
using UnityEngine.UI;

public class ComonScript : MonoBehaviour
{
    public bool DontDestroyEnabled = true;
    public static GameObject panel;
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
    }
	
	// ＥＳＣによるゲーム終了と画面のフェードイン、アウトを行う
	void Update () {
		if (Input.GetKeyDown(KeyCode.Escape)){
			if (SceneManager.GetActiveScene().name == "title"){
				Application.Quit();
				Debug.Log (SceneManager.GetActiveScene().name);
			}else{
                ComonScript.Getting(true, 0);
			}
		}
        Camera.main.transform.position = new Vector3(Random.Range(-1*x,x), Random.Range(-1*x,x),-10);
        if(x>0){
            x -= 0.005f;
        }else{
            x=0;
        }
	}

    //trueで暗転、falseでフェードイン
    public static void Getting(bool dl, int scene){
        if (dl){
            a += Time.deltaTime;
            panel.GetComponent<Image>().color = new Color(0, 0, 0, a);
            if (a >= 1)
                SceneManager.LoadScene(scene);
        }else if(a > 0){
            a -= Time.deltaTime;
            panel.GetComponent<Image>().color = new Color(0, 0, 0, a);
        }
    }

    public static void Shaking(){
        x = 0.3f;
    }
}
