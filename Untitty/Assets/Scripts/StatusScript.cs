using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StatusScript: MonoBehaviour {
    public float longs,x,mx;
    float t,moves;
    public GameObject Hand;
    bool button;
	// Use this for initialization
	void Start () {
        longs = 30;
        moves = 20;
    }
	
	// Update is called once per frame
	void Update () {/*
        mx = Input.GetAxisRaw("Horizontal");
        if ((-0.05f>mx || mx > 0.05) && button==true)
        {
            if (this.name == "Agility")
            {
                longs = Hand.GetComponent<ChooseScript>().unko[0];
            }
            if (this.name == "Jump")
            {
                longs = Hand.GetComponent<ChooseScript>().unko[1];
            }
            if (this.name == "Atack")
            {
                longs = Hand.GetComponent<ChooseScript>().unko[2];
            }
            if (this.name == "ELS")
            {
                longs = Hand.GetComponent<ChooseScript>().unko[3];
            }
            moves = x - longs;
            t = 0;
            button = false;
            Debug.Log("aaa");
        }
        if (-0.05f < mx && mx < 0.05)
        {
            button = true;
        }
        t++;
        x = moves * Mathf.Exp(-0.1f * t) * Mathf.Cos(0.4f * t) + longs;
        transform.localScale = new Vector3(x/3,5,1);*/
	}
}
