<<<<<<< HEAD
﻿using Photon.Pun;
=======
﻿using System.Collections;
using System.Collections.Generic;
>>>>>>> origin/master
using TouchScript.Gestures;
using UnityEngine;
using System;

<<<<<<< HEAD
public class TouchReactScript : MonoBehaviourPunCallbacks {

    public GameObject player;
    public bool shot = false, jump = false;
=======
public class TouchReactScript : MonoBehaviour {

    public int movex;
    public GameObject player;
>>>>>>> origin/master

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
<<<<<<< HEAD
        shot = true;
        //player = GameObject.FindGameObjectWithTag("Player1");
        //photonView.RPC(nameof(player.GetComponent<>().Shot), RpcTarget.All, ++player.projectileId);
        /*
=======
        player = GameObject.FindGameObjectWithTag("Player1");
>>>>>>> origin/master
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
<<<<<<< HEAD
         */
        //print("unchi!");
    }

    void OnFlicked(object sender, EventArgs e){
        jump = true;
        /*
=======
    }

    void OnFlicked(object sender, EventArgs e){
>>>>>>> origin/master
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
<<<<<<< HEAD
         */
=======
>>>>>>> origin/master
    }
}
