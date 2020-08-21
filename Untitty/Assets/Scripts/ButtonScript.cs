using UnityEngine;

public class ButtonScript : MonoBehaviour
{
    public bool button;
    // Start is called before the first frame update
    void Start()
    {
        button = false;
    }

    // Update is called once per frame
    public void OnClick()
    {
        button = true;
    }
}
