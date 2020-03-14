using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharaCScript : CharaScript {
    void Start()
    {
        rb2d = GetComponent<Rigidbody2D>();
    }

    private void Update()
    {
        if (this.tag == "Player1")
        {
            //mx = Input.GetAxis("Horizontal");
        }
        else if (this.tag == "Player2")
        {
            //mx = Input.GetAxis("Horizontal1");
        }
        transform.position += new Vector3(mx * 0.02f, 0, 0);
        jumpvector = new Vector2(toward * 1.5f, 8) * 100;
        Move();
    }
}
