<<<<<<< HEAD
﻿using UnityEngine;
=======
﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
>>>>>>> origin/master

public class CharaCScript : CharaScript {
    void Start()
    {
<<<<<<< HEAD
        speed = 0.02f;
=======
        rb2d = GetComponent<Rigidbody2D>();
>>>>>>> origin/master
    }

    private void Update()
    {
<<<<<<< HEAD
        jumpvector = new Vector2(toward * 1.0f, 8) * 100;
        /*if (this.tag == "Player1")
=======
        if (this.tag == "Player1")
>>>>>>> origin/master
        {
            //mx = Input.GetAxis("Horizontal");
        }
        else if (this.tag == "Player2")
        {
            //mx = Input.GetAxis("Horizontal1");
<<<<<<< HEAD
        }*/
=======
        }
        transform.position += new Vector3(mx * 0.02f, 0, 0);
        jumpvector = new Vector2(toward * 1.5f, 8) * 100;
>>>>>>> origin/master
        Move();
    }
}
