using UnityEngine;

public class Chara1Script : CharaScript
{
    void Start()
    {
        speed = 0.008f;
    }

    private void Update()
    {
        jumpvector = new Vector2(toward * 2.0f, 3) * 100;
        /*
        //int move = script.movex;
        if (this.tag == "Player1")
        {
            //mx = Input.GetAxis("Horizontal");
        }
        else if (this.tag == "Player2")
        {
            //mx = Input.GetAxis("Horizontal2");
        }
        //rb2d.AddForce(new Vector2(move*10,0));*/
        Move();
    }
}
