using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeadScript : MonoBehaviour {
	public GameObject jiki;
    TextMesh tm;

	void Start () {
        tm = this.GetComponent<TextMesh>();
        if (jiki.tag == "Player1")
        {
            tm.text = ("1P");
        }
        else if (jiki.tag == "Player2")
        {
            tm.text = ("2P");
        }
        else if (jiki.tag == "Player3")
        {
            tm.text = ("3P");
        }
        else
        {
            tm.text = ("4P");
        }
    }
	
	void Update () {
		transform.position = jiki.transform.position + new Vector3(0,1,-1);
	}

	void OnTriggerEnter2D (Collider2D obj) {
		if (obj.gameObject.tag != "ShotA" && jiki.tag == "Player1" 
        || obj.gameObject.tag != "ShotB" && jiki.tag == "Player2" 
        || obj.gameObject.tag != "ShotC" && jiki.tag == "Player3" 
        || obj.gameObject.tag != "ShotD" && jiki.tag == "Player4")
			jiki.SendMessage ("Death");
	}
}
