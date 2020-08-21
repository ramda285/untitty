using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StatusScript: MonoBehaviour {
    public float longs,x,mx;
    float t,moves;
    public GameObject chara;
    ChooseScript scr;
    bool button;
	// Use this for initialization
	void Start () {
        longs = 1;
        moves = 1;
        scr = chara.GetComponent<ChooseScript>();
    }
	
	// Update is called once per frame
	void Update () {
        if (this.name == "Agility"){
            longs = scr.aglx;
        }else if (this.name == "Jump"){
            longs = scr.jmpx;
        }else if (this.name == "Attack"){
            longs = scr.atkx;
        }
        if(mx != longs){
            moves = mx - longs;
            t = 0;
        }
        t++;
        x = moves * Mathf.Exp(-0.1f * t) * Mathf.Cos(0.4f * t) + longs;
        transform.localScale = new Vector3(x,1,1);
        mx = longs;





/*
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
        }*/
	}
}
