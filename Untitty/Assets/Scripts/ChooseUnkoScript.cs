using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEngine;

public class ChooseUnkoScript : MonoBehaviour {
    GameObject center;
    public float moves, t;
    float toward;
	// Use this for initialization
	void Start () {
        center = GameObject.Find("Center");
        moves = 0;
        toward = 1;
    }
	
	// Update is called once per frame
	void Update () {
        if(t>=0){
            GestureScript.flick = 0;
            moves = 5f * Mathf.Sin(t/19.4f * toward);
            t--;
        }else{
            
        }
        if(GestureScript.flick == 1){
            t = 19;
            toward = 1;
            ChooseScript.chara++;
        }
        if(GestureScript.flick == -1){
            t = 19;
            toward = -1;
            ChooseScript.chara--;
        }
        transform.RotateAround (center.transform.position, new Vector3(3f,11f,0), moves);
        transform.LookAt(Camera.main.transform.position);
    }
}