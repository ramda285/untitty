using System.Collections;
using System.Collections.Generic;
using TouchScript.Gestures;
using UnityEngine;
using System;

public class TouchReactScript : MonoBehaviour {

    public int movex;
    public GameObject player;

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
        player = GameObject.FindGameObjectWithTag("Player1");
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
    }

    void OnFlicked(object sender, EventArgs e){
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
    }
}
