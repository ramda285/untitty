﻿Shader "Custom/Post Processing/Negative Colors"
{
    Properties
    {
        [HideInInspector]_MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        ZTest Always
        
        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;

            struct vertInput
            {
                float3 position : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct vertOutput
            {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            vertOutput vert(vertInput i)
            {
                vertOutput o;
                o.position = UnityObjectToClipPos(i.position);
                o.uv = i.uv;
                return o;
            }

            fixed4 frag(vertOutput o) : SV_TARGET
            {
                return 1 - tex2D(_MainTex, o.uv);
            }

            ENDCG
        }
    }
}
