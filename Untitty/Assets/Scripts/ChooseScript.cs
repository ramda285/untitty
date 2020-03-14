using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChooseScript : MonoBehaviour
{
    bool dl;
    public static int chara;
    int n;       //頭悪いスイッチ管理
    private AudioSource audio;
    // Start is called before the first frame update
    void Start()
    {
        n=0;
        audio = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        ComonScript.Getting(dl,3);
        if(GestureScript.tap == 1 && n==0){
            dl = true;
            audio.Play();
            n=1;
            print(chara);
        }
    }
}
