<<<<<<< HEAD
﻿using UnityEngine;

public class CharaAScript : CharaScript {
    void Start()
    {
        speed = 0.007f;
=======
﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharaAScript : CharaScript {
    TouchReactScript script;
    void Start()
    {
        rb2d = GetComponent<Rigidbody2D>();
        //script = GameObject.Find("Right Touch").GetComponent<TouchReactScript>();
>>>>>>> origin/master
    }

    private void Update()
    {
<<<<<<< HEAD
        jumpvector = new Vector2(toward * 3f, 6) * 100;
        //int move = script.movex;
        /*if (this.tag == "Player1")
=======
        //int move = script.movex;
        if (this.tag == "Player1")
>>>>>>> origin/master
        {
            //mx = Input.GetAxis("Horizontal");
        }
        else if (this.tag == "Player2")
        {
            //mx = Input.GetAxis("Horizontal2");
<<<<<<< HEAD
        }*/
        //rb2d.AddForce(new Vector2(move*10,0));
=======
        }
        //rb2d.AddForce(new Vector2(move*10,0));
        jumpvector = new Vector2(toward * 3f, 6) * 100;
>>>>>>> origin/master
        Move();
    }
}
