using UnityEngine;

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