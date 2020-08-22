using UnityEngine;

public class Chara3Script : CharaScript
{
    // Start is called before the first frame update
    void Start()
    {
        speed = 0.01f;
        three = new Vector2(0, 2.5f);
    }

    private void Update()
    {
        jumpvector = new Vector2(toward * 2.5f, 4) * 100;
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
