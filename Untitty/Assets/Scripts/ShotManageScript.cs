using System.Collections.Generic;
using UnityEngine;

public class ShotManageScript : MonoBehaviour
{
    [SerializeField]
    //public ShotScript projectilePrefab = default; // Projectileプレハブの参照

    // アクティブな弾のリスト
    private List<ShotScript> activeList = new List<ShotScript>();
    // 非アクティブな弾のオブジェクトプール
    private Stack<ShotScript> inactivePool = new Stack<ShotScript>();

    private void Update() {
        // 逆順にループを回して、activeListの要素が途中で削除されても正しくループが回るようにする
        for (int i = activeList.Count - 1; i >= 0; i--) {
            var projectile = activeList[i];
            if (projectile.IsActive) {
                projectile.OnUpdate();
            } else {
                Remove(projectile);
            }
        }
    }

    // 弾を発射（アクティブ化）するメソッド
    public void Fire(int id, int ownerId, Vector3 origin, Vector2 three, ShotScript projectilePrefab) {
        // 非アクティブの弾があれば使い回す、なければ生成する
        var projectile = (inactivePool.Count > 0)
            ? inactivePool.Pop()
            : Instantiate(projectilePrefab, transform);
        projectile.Activate(id, ownerId, origin, three);
        activeList.Add(projectile);
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

