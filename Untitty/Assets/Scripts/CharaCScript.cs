using UnityEngine;

public class CharaCScript : CharaScript {
    void Start()
    {
        speed = 0.02f;
    }

    private void Update()
    {
        jumpvector = new Vector2(toward * 1.0f, 8) * 100;
        /*if (this.tag == "Player1")
        {
            //mx = Input.GetAxis("Horizontal");
        }
        else if (this.tag == "Player2")
        {
            //mx = Input.GetAxis("Horizontal1");
        }*/
        Move();
    }
}
