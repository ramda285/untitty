using UnityEngine;
using UnityEngine.UI;

public class TutorialScript : MonoBehaviour
{
    private float t;
    bool dl;
    public GameObject tex, chara, touch, sndbg, ComonO;
    public AudioSource bon;
    bool but1,but2,but3,but4,but5,but6;

    // Start is called before the first frame update
    void Start()
    {
        ComonScript.nanid = 3;
        dl = false;
        but1 = false;
        but2 = false;
        but3 = false;
        but4 = false;
        but5 = false;
        but6 = false;
        bon = GetComponent<AudioSource>();
        if(GameObject.Find("Comon(Clone)") == null){
            Instantiate(ComonO);
        }
    }

    // Update is called once per frame
    void Update()
    {
        t += Time.deltaTime*70;
        if(t>30)
            ComonScript.Getting(dl,0);
        if(t > 150 && but1 == false){
            tex.GetComponent<Text>().text = "右に傾けて右に移動";
            if(chara.GetComponent<CharaAScript>().mx >= 5){
                tex.GetComponent<Text>().text = "OK";
                but1 = true;
                t = 251;
            }
        }
        if(but1 && t > 350 && but2 == false){
            tex.GetComponent<Text>().text = "左に傾けて左に移動";
            if(chara.GetComponent<CharaAScript>().mx <= -5){
                tex.GetComponent<Text>().text = "OK";
                but2 = true;
                t = 351;
            }
        }
        if(but2 && t > 450 && but3 == false){
            tex.GetComponent<Text>().text = "上にスライドでジャンプ";
            if(touch.GetComponent<TouchReactScript>().jump || Input.GetButtonUp("Jump")){
                tex.GetComponent<Text>().text = "OK";
                but3 = true;
                t = 451;
            }
        }
        if(but3 && t > 550 && but4 == false){
            tex.GetComponent<Text>().text = "タップで糞";
            if(touch.GetComponent<TouchReactScript>().shot || Input.GetButtonUp("Fire")){
                tex.GetComponent<Text>().text = "OK";
                but4 = true;
                t = 551;
            }
        }
        if(but4 && t > 650){
            if(but5 == false){
                tex.GetComponent<Text>().text = "こいつの上から\n糞を垂らして斃せ";
                sndbg = Instantiate((GameObject)Resources.Load("CharaPU"), new Vector3(7, 7, -1), Quaternion.identity);
                sndbg.tag = "Player2";
                but5 = true;
            }
            if(sndbg == null){
                Camera.main.transform.position -= (Camera.main.transform.position - Vector3.zero + Vector3.forward * 10)/10;
                if(Camera.main.orthographicSize < 5f){
                    Camera.main.orthographicSize += 0.2f;
                }else if(Camera.main.orthographicSize > 7f){
                    Camera.main.orthographicSize = 5f;
                }
                if(but6 == false){
                    bon.Play();
                    t = 651;
                    but6 = true;
                }
                if(t > 650){
                    tex.GetComponent<Text>().text = "準備は完璧です！\n今度こそ";
                }
                if(t > 800){
                    tex.GetComponent<Text>().text = "Welcom to\nPOOP world";
                }
                if(t > 900){
                    PlayerPrefs.SetInt("Tutorial", 1);
                    dl = true;
                    ComonScript.nanid = 1;
                }
            }
        }
    }
}
