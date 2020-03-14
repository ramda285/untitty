using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
//using Photon.Pun;

public class BattleScript : MonoBehaviour {
    int t,at,dn=0;
    float ct = 0;
    int mode;
    public bool pd1 = true, pd2 = true, pd3 = true, pd4 = true, p2c = false, button = false;
    public GameObject Player;
    public static GameObject Playercl;
    public GameObject Player2;
    public static GameObject Playercl2;
    public GameObject rw;
    public GameObject lw;
    public GameObject go;
    public GameObject panel;
    TextMesh tm;
    public AudioSource bgm;
    public AudioSource tin;
    public AudioSource bon;

    void Start () {
        tm = go.GetComponent<TextMesh>();
        switch (ChooseScript.chara % 4 + 1)
        {
            case 4:
                Player = (GameObject)Resources.Load("CharaA");
                break;
            case 3:
                Player = (GameObject)Resources.Load("CharaB");
                break;
            case 2:
                Player = (GameObject)Resources.Load("CharaC");
                break;
            case 1:
                Player = (GameObject)Resources.Load("CharaD");
                break;
        }
    }

    // Update is called once per frame
    void Update()
    {
        ComonScript.Getting(false,0);
        t++;
        if (t < 0 && t > 20)
        {
            rw.transform.position += Vector3.right * 0.5f;
            lw.transform.position += Vector3.left * 0.5f;
        }
        if (t > 30 && t < 120)
        {
            tm.fontSize += 3;
            tm.color = new Color(tm.color.r, tm.color.g, tm.color.b, 1 - (t - 40) * 0.02f);
            tm.transform.position = new Vector3(-t/6f+2.5f,t/6f-4f,-1);
        }
        if (t == 20)
        {
            Playercl = Instantiate(Player, new Vector3(-7, 7, -1), Quaternion.identity) as GameObject;    
            Playercl.tag = "Player1";
            Playercl2 = Instantiate(Player2, new Vector3(7, 7, -1), Quaternion.identity) as GameObject;    
            Playercl2.tag = "Player2";
            //if (Player2.name == "CharaPU") {
                p2c = true;
            //}
            //Player2cl.tag = "Player2";
        }
        if (t >= 50)
        {
            if (Playercl == null && pd1)
            {
                bon.PlayOneShot(bon.clip);
                pd1 = false;
                dn++;
            }
            if (Playercl2 == null && pd2)
            {
                bon.PlayOneShot(bon.clip);
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
            tin.PlayOneShot(tin.clip);
            tm.fontSize = 25;
            tm.transform.position = new Vector3(-10f, 4f, -1);
            tm.color = new Color(tm.color.r, tm.color.g, tm.color.b, 1);

            if (pd1 == false)
            {
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
                }
            }
            else
            {
                tm.text = ("１ｐ k　ta");
            }
            Debug.Log("aiueo");
        }
        else if (at >= 250)
        {
            tm.fontSize = 13;
            tm.text = ("Fz　W　xepy\ndth　W　g'o　^yb4");
            if (Input.GetButtonUp("Jump"))
            {
                mode = 1;
                //button = true;
                back();
            }else if (Input.GetButtonUp("Fire1"))
            {
                mode = 2;
                //button = true;
                back();
            }
            //if (button == true)
            //デバッグ用
            mode = 1;
            back();
        }
    }

    void back() {
        if (ct < 1)
        {
            ct += 0.03f;
            panel.GetComponent<Image>().color = new Color(0, 0, 0, ct);
        }
        if (ct >= 1)
            if (mode == 1)
            {
                SceneManager.LoadScene("main");
            }
            else if (mode == 2)
            {
                SceneManager.LoadScene("choose");
            }
    }
}
