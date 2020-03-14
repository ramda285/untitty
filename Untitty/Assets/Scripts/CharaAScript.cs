using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharaAScript : CharaScript {
    TouchReactScript script;
    void Start()
    {
        rb2d = GetComponent<Rigidbody2D>();
        //script = GameObject.Find("Right Touch").GetComponent<TouchReactScript>();
    }

    private void Update()
    {
        //int move = script.movex;
        if (this.tag == "Player1")
        {
            //mx = Input.GetAxis("Horizontal");
        }
        else if (this.tag == "Player2")
        {
            //mx = Input.GetAxis("Horizontal2");
        }
        //rb2d.AddForce(new Vector2(move*10,0));
        jumpvector = new Vector2(toward * 3f, 6) * 100;
        Move();
    }
}
