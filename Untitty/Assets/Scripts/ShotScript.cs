using UnityEngine;
public class ShotScript : MonoBehaviour
{
    public int Id { get; private set; } // 弾のID
    public int OwnerId { get; private set; } // 弾を発射したプレイヤーのID
    public bool Equals(int id, int ownerId) => id == Id && ownerId == OwnerId;
    public bool IsActive => gameObject.activeSelf;

    public void Activate(int id, int ownerId, Vector3 origin, Vector2 three) { // メソッド名変更
        Id = id;
        OwnerId = ownerId;
        transform.position = origin;
        gameObject.SetActive(true);
        GetComponent<Rigidbody2D>().AddForce(three * 100);
    }
    
    public void OnUpdate() { 
        // publicにしてメソッド名変更

    }
    
    public void Deactivate() {
        gameObject.SetActive(false);
    }
    
    private void OnBecameInvisible() {
        Deactivate();
    }
}