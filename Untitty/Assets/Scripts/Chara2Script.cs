using UnityEngine;

public class Chara2Script : CharaScript
{
    // Start is called before the first frame update
    void Start()
    {
        speed = 0.008f;
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
        transform.position += new Vector3(mx*0.003f,0,0);
        Move();
    }
}
