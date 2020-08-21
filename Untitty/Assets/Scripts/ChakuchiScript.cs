using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChakuchiScript : MonoBehaviour
{
    // Start is called before the first frame update
    float t;
    void Start()
    {
        t = 0;
    }

    // Update is called once per frame
    void Update()
    {
        t+=Time.deltaTime*60;
        if(t >= 150)
        Destroy(this.gameObject);
    }
}
