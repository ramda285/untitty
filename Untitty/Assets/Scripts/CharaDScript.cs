using System.Collections;
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
}
