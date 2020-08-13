using System;
using TouchScript.Gestures;
using UnityEngine;

public class GestureScript : MonoBehaviour
{
    Vector2 vec;
    public static int flick;
    public static int tap;
    void Start(){
        flick = 0;
        tap = 0;
    }
    void OnEnable()
    {
        GetComponent<FlickGesture>().Flicked += OnFlicked;
        GetComponent<TapGesture>().Tapped += OnTapped;
    }

    void OnDisable()
    {
        GetComponent<FlickGesture>().Flicked -= OnFlicked;
        GetComponent<TapGesture>().Tapped -= OnTapped;
    }

    void OnFlicked( object sender, EventArgs e )
    {
        var gesture = sender as FlickGesture;
        if (gesture.State != FlickGesture.GestureState.Recognized)
            return;
        vec = GetComponent<FlickGesture>().ScreenFlickVector;
        //Debug.Log( ""+vec.x+""+vec.y);
        if(vec.x > 1 && vec.y < -1){
            flick = 1;
        }
        if(vec.x < -1 && vec.y > 1){
            flick = -1;
        }
    }

    void OnTapped( object sender, EventArgs e ){
        tap++;
    }
}
