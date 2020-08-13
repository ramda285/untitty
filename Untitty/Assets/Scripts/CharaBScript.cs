<<<<<<< HEAD
﻿using UnityEngine;
=======
﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
>>>>>>> origin/master

public class CharaBScript : CharaScript {
    void Start()
    {
<<<<<<< HEAD
        speed = 0.011f;
=======
        rb2d = GetComponent<Rigidbody2D>();
>>>>>>> origin/master
    }

    private void Update()
    {
<<<<<<< HEAD
        jumpvector = new Vector2(toward * 3.5f, 5) * 100;
        /*if (this.tag == "Player1")
=======
        if (this.tag == "Player1")
>>>>>>> origin/master
        {
            //mx = Input.GetAxis("Horizontal")*0.8f;
        }
        else if (this.tag == "Player2")
        {
            //mx = Input.GetAxis("Horizontal2")*0.8f;
<<<<<<< HEAD
        }*/
=======
        }
        jumpvector = new Vector2(toward * 1.5f, 2) * 100;
>>>>>>> origin/master
        Move();
    }
}
