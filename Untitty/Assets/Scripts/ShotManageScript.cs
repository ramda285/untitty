using System.Collections.Generic;
using UnityEngine;

public class ShotManageScript : MonoBehaviour
{
    [SerializeField]
    private ShotScript projectilePre = default; // Projectileプレハブの参照
    // アクティブな弾のリスト
    private List<ShotScript> activeList = new List<ShotScript>();
    // 非アクティブな弾のオブジェクトプール
    private Stack<ShotScript> inactivePool = new Stack<ShotScript>();
    private ShotScript projectile;

    private void Update() {
        // 逆順にループを回して、activeListの要素が途中で削除されても正しくループが回るようにする
        for (int i = activeList.Count - 1; i >= 0; i--) {
            var projectile = activeList[i];
            //print("弾"+projectile.IsActive);
            if (projectile.IsActive) {
                projectile.OnUpdate();
            } else {
                Remove(projectile);
            }
            //print("弾生存数"+activeList.Count);
        }
    }

    // 弾を発射（アクティブ化）するメソッド
    public void Fire(int id, int ownerId, Vector3 origin, Vector2 three) {
        // 非アクティブの弾があれば使い回す、なければ生成する
        if (inactivePool.Count > 0){
            projectile = inactivePool.Pop();
            if(projectile == null){
                //print("出ない"+inactivePool.Count);
                inactivePool.Clear();
            }
        }else{
            projectile = Instantiate(projectilePre, transform);
        }
        projectile.Activate(id, ownerId, origin + Vector3.forward, three);
        activeList.Add(projectile);
        //print("現在プール"+inactivePool.Count);
        //print("弾番号"+id);
    }

    // 弾を消去（非アクティブ化）するメソッド
    public void Remove(ShotScript projectile) {
        activeList.Remove(projectile);
        projectile.Deactivate();
        inactivePool.Push(projectile);
    }

    public void Remove(int id, int ownerId) {
        foreach (var projectile in activeList) {
            if (projectile.Equals(id, ownerId)) {
                Remove(projectile);
                break;
            }
        }
    }
}

