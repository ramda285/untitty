using UnityEngine;

public class ChooseUnkoScript : MonoBehaviour {
    
	// Use this for initialization
	void Start () {
        
    }
	
	// Update is called once per frame
	void Update () {
        transform.LookAt(Camera.main.transform.position);
    }
}