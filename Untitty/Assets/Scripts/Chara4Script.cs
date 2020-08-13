using UnityEngine;

public class Chara4Script : CharaScript
{
    // Start is called before the first frame update
    void Start()
    {
        speed = 0.004f;
    }

    private void Update()
    {
        jumpvector = new Vector2(toward * 7.0f, 20f) * 100;
        /*
        if (this.tag == "Player1")
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
