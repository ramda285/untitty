using UnityEngine;
using UnityEngine.UI;

public class ChooseUnkoScript : MonoBehaviour {
	public SpriteRenderer sprite;		//spriteじゃなくてマテリアルなんだよなぁ
	float rgb,a,t,dt;
	// Use this for initialization
	void Start () {
		sprite = transform.GetChild(0).gameObject.GetComponent<SpriteRenderer>();
		t = 0;
		dt = 0;
    }
	
	// Update is called once per frame
	void Update () {
        transform.LookAt(Camera.main.transform.position);
		if(transform.position.z <= 1){
			if (ChooseScript.dl){
				Flash();
			}else{
				Tenmetsu();
			}
		}else{
			Dark();
		}
		sprite.color = new Color(rgb, rgb, rgb, a);
    }

	void Tenmetsu(){
		//アクティブになったときに軽く点滅
		rgb = 255f;
		a = Mathf.Abs(Mathf.Sin(t/15f)/4);
		t += Time.deltaTime*60f;
	}

	void Dark(){
		//非アクティブでは暗くなる
		rgb = 0;
		a = 0.5f;
		t = 0;
	}

	void Flash(){
		rgb = 255f;
		dt += Time.deltaTime*240f;
		if(dt <= 20 || (dt > 40 && dt <= 60)){
			a = 1;
		}else if((dt > 20 && dt <= 40) || (dt > 60 && dt <= 80)){
			a = 0;
		}
	}
}