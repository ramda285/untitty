using UnityEngine;
using UnityEngine.UI;

public class BattleScript : MonoBehaviour {
    int t=-10,at,dn=0;
    bool dl = false;
    //int mode;
    public bool pd1 = true, pd2 = true;
    GameObject Player;
    public static GameObject Playercl;
    GameObject Player2;
    public static GameObject Playercl2;
    public GameObject rw;
    public GameObject lw;
    public GameObject go;
    TextMesh tm;
    public AudioSource bgm;
    AudioSource auso;
    public AudioClip tin;
    public AudioClip bon;
    public AudioClip gob;

    void Start () {
        tm = go.GetComponent<TextMesh>();
        auso = GetComponent<AudioSource>();
        switch (ChooseScript.chara % 8)
        {
            case 0:
                Player = (GameObject)Resources.Load("CharaA");
                break;
            case 1:
                Player = (GameObject)Resources.Load("CharaB");
                break;
            case 2:
                Player = (GameObject)Resources.Load("CharaC");
                break;
            case 3:
                Player = (GameObject)Resources.Load("CharaD");
                break;
            case 4:
                Player = (GameObject)Resources.Load("Chara1");
                break;
            case 5:
                Player = (GameObject)Resources.Load("Chara2");
                break;
            case 6:
                Player = (GameObject)Resources.Load("Chara3");
                break;
            case 7:
                Player = (GameObject)Resources.Load("Chara4");
                break;
            default:
                break;
        }
        Player2 = (GameObject)Resources.Load("CharaPU");
    }

    // Update is called once per frame
    void Update()
    {
        ComonScript.Getting(dl,1);
        t++;
        if (t > 0 && t < 20)
        {
            rw.transform.position += Vector3.right * 1.2f;
            lw.transform.position += Vector3.left * 1.2f;
        }
        if (t > 30 && t < 120)
        {
            tm.fontSize += 3;
            tm.color = new Color(tm.color.r, tm.color.g, tm.color.b, 1 - (t - 40) * 0.02f);
            tm.transform.position = new Vector3(-t/6f+2.5f,t/6f-4f,-1);
        }
        if (t == 20)
        {
            auso.PlayOneShot(gob);
            Playercl = Instantiate(Player, new Vector3(-7, 7, -1), Quaternion.identity) as GameObject;    
            Playercl.tag = "Player1";
            Playercl2 = Instantiate(Player2, new Vector3(7, 7, -1), Quaternion.identity) as GameObject;    
            Playercl2.tag = "Player2";
            //if (Player2.name == "CharaPU") {
            //    p2c = true;
            //}
            //Player2cl.tag = "Player2";
        }
        if (t >= 50)
        {
            if (Playercl == null && pd1)
            {
                auso.PlayOneShot(bon);
                pd1 = false;
                dn++;
            }
            if (Playercl2 == null && pd2)
            {
                auso.PlayOneShot(bon);
                pd2 = false;
                dn++;
            }
            /*
            if (Player3cl == null && pd3 && (TitleScript.selectmode == "sannin" || TitleScript.selectmode == "yonin"))
            {
                bon.PlayOneShot(bon.clip);
                pd3 = false;
                dn++;
            }
            if (Player4cl == null && pd4 && TitleScript.selectmode == "yonin")
            {
                bon.PlayOneShot(bon.clip);
                pd4 = false;
                dn++;
            }
            */
            if (dn >= 1)
            {
                End();
                at++;
                bgm.volume -= 0.02f;
            }
        }
    }

    public void End() {
        if (at == 100)
        {
            auso.PlayOneShot(tin);
            tm.fontSize = 25;
            tm.transform.position = new Vector3(-10f, 4f, -1);
            tm.color = new Color(tm.color.r, tm.color.g, tm.color.b, 1);

            if (pd1 == false)
            {/*
                if (pd2 == false)
                {
                    if (pd3 == false)
                    {
                        if (pd4 == false)
                        {
                            tm.text = ("vg0:");
                        }
                        else
                        {
                            tm.text = ("４ｐ k　ta");
                        }
                    }
                    else
                    {
                        tm.text = ("３ｐ k　ta");
                    }
                }
                else
                {
                    if (p2c == true)
                    {
                        tm.text = ("wg　k　ta");
                    }
                    else
                    {
                        tm.text = ("２ｐ k　ta");
                    }
                }*/
                tm.text = ("wg　k　ta");
            }
            else
            {
                tm.text = ("3uq k　ta");
            }
        }
        else if (at >= 250)
        {
            /*tm.fontSize = 13;
            tm.text = ("roeS　W　xepy\nqZK　W　g'o　^yb4");
            if (Input.GetButtonUp("Jump"))
            {
                mode = 1;
                //button = true;
                dl =true;
            }else if (Input.GetButtonUp("Fire"))
            {
                mode = 3;
                //button = true;
                dl =true;
            }
            //スマホ用モード*/
            dl =true;
        }
    }
}
