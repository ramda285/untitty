using UnityEngine;

public class CharaAScript : CharaScript {
    void Start()
    {
        speed = 0.007f;
    }

    private void Update()
    {
        jumpvector = new Vector2(toward * 3f, 6) * 100;
        //int move = script.movex;
        /*if (this.tag == "Player1")
        {
            //mx = Input.GetAxis("Horizontal");
        }
        else if (this.tag == "Player2")
        {
            //mx = Input.GetAxis("Horizontal2");
        }*/
        //rb2d.AddForce(new Vector2(move*10,0));
        Move();
    }
}
