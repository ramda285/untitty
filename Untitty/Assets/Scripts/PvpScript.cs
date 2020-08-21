using UnityEngine;
using UnityEngine.UI;
using Photon.Pun;
using Photon.Realtime;

public class PvpScript : MonoBehaviourPunCallbacks {
    float t,at;
    int dn;
    bool dl = false;
    int mode;
    public bool someonesdeath;
    public GameObject Player;
    public static GameObject Playercl;
    public GameObject rw;
    public GameObject lw;
    public GameObject go;
    TextMesh tm;
    public AudioSource bgm;
    AudioSource auso;
    public AudioClip tin;
    public AudioClip bon;
    public AudioClip gob;
    public AudioClip donichi;
    bool but1,but2,but3;

    void Start () {
        PhotonScript.num++;
        but1 = false;
        but2 = false;
        but3 = false;
        t = -10;
        dn = 0;
        tm = go.GetComponent<TextMesh>();
        auso = GetComponent<AudioSource>();
		if(PhotonScript.king == 1){
            var properties  = new ExitGames.Client.Photon.Hashtable();
            properties.Add( "ohcan", PhotonScript.king );
            PhotonNetwork.CurrentRoom.SetCustomProperties( properties );
        }
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
        //if(PhotonScript.king == 1 || PhotonNetwork.LocalPlayer.CustomProperties["KING"] == 1)
        //    bgm.clip = donichi;
    }

    // Update is called once per frame
    void Update()
    {
            //pos = Random.Range(1,2);
        ComonScript.Getting(dl,mode);
        t+=Time.deltaTime*60;
        if (t > 0 && t < 50)
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
        if (t >= 20 && but1 == false)
        {
            auso.PlayOneShot(gob);
            if(PhotonNetwork.LocalPlayer.IsMasterClient){
                Playercl = PhotonNetwork.Instantiate(Player.name, new Vector3(-7, 7, -1), Quaternion.identity) as GameObject;    
            }else{
                Playercl = PhotonNetwork.Instantiate(Player.name, new Vector3(7, 7, -1), Quaternion.identity) as GameObject;    
            }
            //Playercl = PhotonNetwork.Instantiate(Player.name, new Vector3(Random.Range(-7f,7f), 7, -1), Quaternion.identity);
            Playercl.tag = "Player1";
            but1 = true;
        }
        if (t > 50)
        {
            if (someonesdeath)
            {
                auso.PlayOneShot(bon);
                someonesdeath = false;
                dn++;
            }
            if(PhotonNetwork.CurrentRoom.PlayerCount != 2 && dn == 0){
                tm.fontSize = 25;
                tm.transform.position = new Vector3(-10f, 4f, -1);
                tm.color = new Color(tm.color.r, tm.color.g, tm.color.b, 1);
                tm.text = "5o\\";
                dn++;
            }
            /*
            if (Playercl2 == null && pd2)
            {
                auso.PlayOneShot(bon);
                pd2 = false;
                dn++;
            }
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
                at+=Time.deltaTime*60;
                bgm.volume -= 0.02f;
            }
        }
    }

    public void End() {
        if (at >= 100 && but2 == false)
        {
            auso.PlayOneShot(tin);
            tm.fontSize = 25;
            tm.transform.position = new Vector3(-10f, 4f, -1);
            tm.color = new Color(tm.color.r, tm.color.g, tm.color.b, 1);

            if (Playercl)
            {
                PhotonScript.win++;
                PhotonScript.cwin++;
                tm.text = ("3uq k　ta");
            }
            else
            {
                PhotonScript.cwin = 0;
                PhotonScript.king = 0;
                tm.text = ("wg k　ta");
            }
            but2 = true;
        }
        else if (at > 250)
        {
            /*tm.fontSize = 13;
            tm.text = ("roeS　W　xepy\nqZK　W　g'o　^yb4");*/
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
            //スマホ用モード
            PhotonNetwork.LeaveRoom();
            mode = 1;
            dl =true;
            print(""+(PhotonScript.cwin-1)*(PhotonScript.cwin-1)*5);
            if (PhotonScript.cwin != 0 && (PhotonScript.cwin-1)*(PhotonScript.cwin-1)*5 > Random.Range(0,100))
                PhotonScript.king = 1;
            PlayerPrefs.SetInt("NUM", PhotonScript.num);
            PlayerPrefs.SetInt("WIN", PhotonScript.win);
            PlayerPrefs.SetInt("CWIN", PhotonScript.cwin);
            PlayerPrefs.SetInt("KING", PhotonScript.king);
            PlayerPrefs.Save ();
        }
    }
    
    public override void OnRoomPropertiesUpdate( ExitGames.Client.Photon.Hashtable changedProperties ){
		object value = null;
		if (changedProperties.TryGetValue ("ohcan", out value)) {
			bgm.clip = donichi;
            bgm.Play();
		}
	}
}