using UnityEngine;
using Photon.Pun;
using Photon.Realtime;
using UnityEngine.UI;

public class PhotonScript : MonoBehaviourPunCallbacks {

    public GameObject modoru, hajimeru, point, score;
    GameObject Player;
    RoomOptions room = new RoomOptions();
    public static int num, win, cwin, king;
    bool dl;
    int scene = 0;
    int t;
    int n;
    float t2;
    bool serching = true;
    // Use this for initialization
    void Start () {
        //旧バージョンでは引数必須でしたが、PUN2では不要です。
        
        PhotonNetwork.SendRate = 20; // 1秒間にメッセージ送信を行う回数
        PhotonNetwork.SerializationRate = 10; // 1秒間にオブジェクト同期を行う回
        //閾値　やめたほうがいいかも
        PhotonNetwork.PrecisionForVectorSynchronization = 0.00001f;
        PhotonNetwork.PrecisionForQuaternionSynchronization = 1f;
        PhotonNetwork.PrecisionForFloatSynchronization = 0.01f;
        dl = false;
        num = PlayerPrefs.GetInt("NUM",0);
        win = PlayerPrefs.GetInt("WIN",0);
        cwin = PlayerPrefs.GetInt("CWIN",0);
        king = PlayerPrefs.GetInt("KING",0);
        score.GetComponent<Text>().text = num + "戦" + win  + "勝";
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
        PhotonNetwork.JoinRandomRoom();
    }

    void Update(){
        ComonScript.Getting(dl,scene);        
        if (modoru.GetComponent<ButtonScript>().button == true){
            dl = true;
            scene = 0;
            PhotonNetwork.LeaveRoom();
        }else{
            if (PhotonNetwork.InRoom){
                if(PhotonNetwork.CurrentRoom.PlayerCount == 2){
                    serching = false;
                    point.GetComponent<Text>().text = "qepy 3ew T\nnztljdq";
                    room.IsOpen = false;
                }
            }else{
                room.MaxPlayers = 2;
                room.IsOpen = true;
                PhotonNetwork.CreateRoom(""+n, room, TypedLobby.Default);
                n++;
            }
            if(serching){
                t++;
                if(0<t && t<100){
                    point.GetComponent<Text>().text = "qepy 3ew !\nxTdw ejr>";
                }else if(100<t && t<200){
                    point.GetComponent<Text>().text = "qepy 3ew !\nxTdw ejr>>";
                }else if(200<t && t<300){
                    point.GetComponent<Text>().text = "qepy 3ew !\nxTdw ejr>>>";
                }else if(t>300){
                    t = 0;
                }
            }else{
                t2 += Time.deltaTime;
                if(t2 >= 3){
                    dl = true;
                    scene = 5;
                }
            }
        }
        if(hajimeru.GetComponent<ButtonScript>().button == true){
            PhotonNetwork.LeaveRoom();
            PhotonNetwork.ConnectUsingSettings();
            hajimeru.GetComponent<ButtonScript>().button = false;
            //type = 5;
        }
    }
/*
    void OnGUI()
    {
        //ログインの状態を画面上に出力
        //print(PhotonNetwork.NetworkClientState.ToString());
    }

    //ルームに入室前に呼び出される
    public override void OnConnectedToMaster() {
        // "room"という名前のルームに参加する（ルームが無ければ作成してから参加する）
        
    }
*/

    //ルームに入室後に呼び出される
    public override void OnJoinedRoom(){
        //キャラクターを生成
        GameObject myunko = PhotonNetwork.Instantiate(Player.name, Vector3.zero, Quaternion.identity, 0);
        myunko.tag = "Player1";
        //自分だけが操作できるようにスクリプトを有効にする
        CharaAScript myscript = myunko.GetComponent<CharaAScript>();
        myscript.enabled = true;
    }

    //誰かが部屋に入る
    public override void OnPlayerEnteredRoom(Player player) {
        //
        //Handheld.Vibrate ();
    }

    public override void OnJoinRoomFailed(short returnCode, string message) {
        Debug.Log($"ルーム参加に失敗しました: {message}");
    }

    public override void OnCreateRoomFailed(short returnCode, string message)
    {
        Debug.Log("何がいかんのやろうなぁ");
    }
}