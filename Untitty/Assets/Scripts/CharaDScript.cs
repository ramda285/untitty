<<<<<<< HEAD
﻿using UnityEngine;

public class CharaDScript : CharaScript{
    public bool jump2;

    void Start(){
        speed = 0.008f;
        jump2 = false;
    }

    private void Update(){
        jumpvector = new Vector2(toward * 3.0f, 4) * 100;
        Move();
        if (jump2 && jump == false && (touch.GetComponent<TouchReactScript>().jump || Input.GetButtonUp("Jump"))){
            auso.PlayOneShot(pyon);
            rb2d.AddForce(new Vector2(0, 3) * 100);
=======
﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharaDScript : CharaScript
{
    public bool jump2;

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
            //mx = Input.GetAxis("Horizontal2");
        }
        jumpvector = new Vector2(toward * 3.0f, 3) * 100;
        Move();
        if ((this.tag == "Player1" && Input.GetButtonDown("Jump") || this.tag == "Player2" && Input.GetButtonDown("Jump2")) && this.jump == false && this.jump2 == true)
        {
            pyon.PlayOneShot(pyon.clip);
            rb2d.AddForce(jumpvector*0.7f);
>>>>>>> origin/master
            jump2 = false;
        }
    }
    void OnCollisionStay2D(Collision2D obj)
    {
        if (obj.gameObject.name == "Ground")
        {
            jump2 = true;
        }
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/master
