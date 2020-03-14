using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharaBScript : CharaScript {
    void Start()
    {
        rb2d = GetComponent<Rigidbody2D>();
    }

    private void Update()
    {
        if (this.tag == "Player1")
        {
            //mx = Input.GetAxis("Horizontal")*0.8f;
        }
        else if (this.tag == "Player2")
        {
            //mx = Input.GetAxis("Horizontal2")*0.8f;
        }
        jumpvector = new Vector2(toward * 1.5f, 2) * 100;
        Move();
    }
}
