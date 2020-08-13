using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetsumeiScript : MonoBehaviour {
    float mx;
    public bool dt=false;
    public int hanum=0,hanun;
    public TextMesh tm;
    // Use this for initialization
    void Start () {
        tm = GetComponent<TextMesh>();
    }
	
	// Update is called once per frame
	void Update () {
        mx = Input.GetAxisRaw("Horizontal");
        if (mx == 1 && dt == true)
        {
            hanum++;
            dt = false;
        } else if (mx == -1 && dt == true) {
            hanum += 3;
            dt = false;
        }
        else if (mx == 0) { dt = true; }
        hanun = Mathf.Abs(hanum % 4);
        if (hanun == 0) {
            tm.text = "2z4 k 4yb";
        } else if (hanun == 1) {
            tm.text = "9h f,. 4yb";
        } else if (hanun == 2) {
            tm.text = "qth s\" 4yb";
        } else if (hanun == 3) {
            tm.text = "iS s\" 4yb";
        } 
	}
}
