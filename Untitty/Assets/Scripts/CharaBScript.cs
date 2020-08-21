using UnityEngine;

public class CharaBScript : CharaScript {
    void Start()
    {
        speed = 0.011f;
    }

    private void Update()
    {
        jumpvector = new Vector2(toward * 3.5f, 5) * 100;
        /*if (this.tag == "Player1")
        {
            //mx = Input.GetAxis("Horizontal")*0.8f;
        }
        else if (this.tag == "Player2")
        {
            //mx = Input.GetAxis("Horizontal2")*0.8f;
        }*/
        Move();
    }
}
