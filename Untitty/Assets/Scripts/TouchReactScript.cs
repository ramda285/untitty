using Photon.Pun;
using TouchScript.Gestures;
using UnityEngine;
using System;

public class TouchReactScript : MonoBehaviourPunCallbacks {

    public GameObject player;
    public bool shot = false, jump = false;

    void OnEnable()
    {
        GetComponent<TapGesture>().Tapped += OnTapped;
        GetComponent<FlickGesture>().Flicked += OnFlicked;
    }

    void OnDisable()
    {
        GetComponent<TapGesture>().Tapped -= OnTapped;
        GetComponent<FlickGesture>().Flicked -= OnFlicked;
    }

    void OnTapped( object sender, EventArgs e )
    {
        shot = true;
        //player = GameObject.FindGameObjectWithTag("Player1");
        //photonView.RPC(nameof(player.GetComponent<>().Shot), RpcTarget.All, ++player.projectileId);
        /*
        switch (player.name){
            case "CharaA(Clone)":
            player.GetComponent<CharaAScript>().Shot();
            break;
            case "CharaB(Clone)":
            player.GetComponent<CharaBScript>().Shot();
            break;
            case "CharaC(Clone)":
            player.GetComponent<CharaCScript>().Shot();
            break;
            case "CharaD(Clone)":
            player.GetComponent<CharaDScript>().Shot();
            break;
            default:
            break;
        }
         */
        //print("unchi!");
    }

    void OnFlicked(object sender, EventArgs e){
        jump = true;
        /*
        player = GameObject.FindGameObjectWithTag("Player1");
        switch (player.name){
            case "CharaA(Clone)":
            player.GetComponent<CharaAScript>().Jump();
            break;
            case "CharaB(Clone)":
            player.GetComponent<CharaBScript>().Jump();
            break;
            case "CharaC(Clone)":
            player.GetComponent<CharaCScript>().Jump();
            break;
            case "CharaD(Clone)":
            player.GetComponent<CharaDScript>().Jump();
            break;
            default:
            break;
        }
         */
    }
}
